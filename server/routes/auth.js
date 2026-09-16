const express = require('express');
const bcrypt = require('bcryptjs');
const { z } = require('zod');
const prisma = require('../config/prisma');
const { signToken, requireAuth } = require('../middleware/auth');

const router = express.Router();

const signupSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  displayName: z.string().min(2).max(40),
});

router.post('/signup', async (req, res) => {
  const parsed = signupSchema.safeParse(req.body);
  if (!parsed.success) {
    return res.status(400).json({ error: parsed.error.flatten() });
  }
  const { email, password, displayName } = parsed.data;

  const existing = await prisma.user.findUnique({ where: { email } });
  if (existing) {
    return res.status(409).json({ error: 'Email already registered' });
  }

  const passwordHash = await bcrypt.hash(password, 12);

  const user = await prisma.user.create({
    data: {
      email,
      passwordHash,
      displayName,
      wallet: { create: { coinBalance: 100, diamondBalance: 0 } }, // small signup bonus
    },
    include: { wallet: true },
  });

  const token = signToken(user);
  res.status(201).json({
    token,
    user: { id: user.id, email: user.email, displayName: user.displayName, wallet: user.wallet },
  });
});

const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(1),
});

router.post('/login', async (req, res) => {
  const parsed = loginSchema.safeParse(req.body);
  if (!parsed.success) {
    return res.status(400).json({ error: parsed.error.flatten() });
  }
  const { email, password } = parsed.data;

  const user = await prisma.user.findUnique({ where: { email }, include: { wallet: true } });
  if (!user) return res.status(401).json({ error: 'Invalid credentials' });

  const valid = await bcrypt.compare(password, user.passwordHash);
  if (!valid) return res.status(401).json({ error: 'Invalid credentials' });

  const token = signToken(user);
  res.json({
    token,
    user: { id: user.id, email: user.email, displayName: user.displayName, wallet: user.wallet },
  });
});

router.get('/me', requireAuth, async (req, res) => {
  const user = await prisma.user.findUnique({
    where: { id: req.userId },
    include: { wallet: true },
  });
  if (!user) return res.status(404).json({ error: 'User not found' });
  res.json({
    id: user.id,
    email: user.email,
    displayName: user.displayName,
    avatarUrl: user.avatarUrl,
    level: user.level,
    wallet: user.wallet,
  });
});

/// Issues a short-lived ZEGOCLOUD room token so the app never ships a raw
/// AppSign in the client build. Requires ZEGO_APP_ID / ZEGO_SERVER_SECRET
/// in the environment — implement with ZEGOCLOUD's token server SDK.
router.post('/zego-token', requireAuth, async (req, res) => {
  const { roomId } = req.body;
  if (!roomId) return res.status(400).json({ error: 'roomId is required' });

  // TODO: generate a real token, e.g. using ZEGOCLOUD's `generateToken04`
  // helper from their server-side token package with ZEGO_APP_ID and
  // ZEGO_SERVER_SECRET from process.env.
  return res.status(501).json({
    error: 'Not implemented — plug in ZEGOCLOUD server-side token generation here.',
  });
});

module.exports = router;
