import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init error: $e");
  }
  runApp(const DodiLiveApp());
}

class DodiLiveApp extends StatelessWidget {
  const DodiLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dodi Live',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF120B22),
      ),
      home: const AuthWrapper(),
    );
  }
}

// فاحص حالة التسجيل لتوجيه المستخدم للبروفايل أو الغرفة مباشرة
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.pink)));
        }
        if (snapshot.hasData) {
          return const ProfileScreen(); // لو مسجل يدخل على البروفايل والغرفة
        }
        return const LoginScreen(); // لو مش مسجل يدخل على شاشة الدخول
      },
    );
  }
}

// 1. شاشة تسجيل الدخول وإنشاء الحساب التلقائي
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _loginOrRegister() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    try {
      UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      
      // إنشاء بروفايل للمستخدم في Firestore لو مش موجود
      await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'email': cred.user!.email,
        'name': cred.user!.email!.split('@')[0],
        'diamonds': 1000, // رصيد افتراضي ماسات هدية للتسجيل
        'followers': 0,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

    } catch (e) {
      // لو الحساب مش موجود، نعمله تسجيل جديد تلقائي
      try {
        UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'email': cred.user!.email,
          'name': cred.user!.email!.split('@')[0],
          'diamonds': 1000,
          'followers': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ في التسجيل: $err')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A0845), Color(0xFF120B22)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.live_tv, size: 80, color: Colors.pinkAccent),
                const SizedBox(height: 16),
                const Text('Dodi Live 👑', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني',
                    filled: true,
                    fillColor: Colors.black45,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'كلمة المرور',
                    filled: true,
                    fillColor: Colors.black45,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.pink)
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                          onPressed: _loginOrRegister,
                          child: const Text('دخول / تسجيل حساب 🚀', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 2. شاشة البروفايل والمحفظة (الرصيد والماسات)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي والمحفظة 💎'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.pink));
          }
          var userData = snapshot.data!.data() as Map<String, dynamic>? ?? {};
          int diamonds = userData['diamonds'] ?? 1000;
          String name = userData['name'] ?? 'مستخدم دودي';

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const CircleAvatar(radius: 50, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 60, color: Colors.white)),
                const SizedBox(height: 16),
                Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Text(user?.email ?? '', style: const TextStyle(color: Colors.white54)),
                const SizedBox(height: 30),
                // صندوق المحفظة والماسات (عصب التطبيق)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.diamond, color: Colors.amber, size: 32),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('رصيد الماسات 💎', style: TextStyle(color: Colors.white60, fontSize: 12)),
                              Text('$diamonds ماسة', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                        onPressed: () async {
                          // شحن رصيد افتراضي (زيادة 500 ماسة تجريبياً)
                          await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
                            'diamonds': diamonds + 500,
                          });
                        },
                        child: const Text('شحن ⚡'),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LiveRoomScreen()));
                  },
                  child: const Text('الانتقال لغرفة البث المباشر 🎥', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 3. شاشة البث المباشر الأساسية (الغرفة، المايكات، الشات الحي، والهدايا)
class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  final TextEditingController _msgController = TextEditingController();

  void _sendMessage() async {
    if (_msgController.text.trim().isEmpty) return;
    String text = _msgController.text.trim();
    _msgController.clear();
    final user = FirebaseAuth.instance.currentUser;

    try {
      await FirebaseFirestore.instance.collection('live_chat_messages').add({
        'sender': user?.email?.split('@')[0] ?? 'مستخدم',
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Error sending: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2A0845), Color(0xFF120B22)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الشريط العلوي للبث
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.pink)),
                        child: Row(
                          children: const [
                            CircleAvatar(radius: 10, backgroundColor: Colors.pink, child: Icon(Icons.star, size: 12, color: Colors.white)),
                            SizedBox(width: 6),
                            Text('غرفة البث الحية 🎥', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                // شبكة المايكات الفخمة داخل الغرفة
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: List.generate(4, (index) => Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.amber, width: 2)),
                          child: const CircleAvatar(radius: 24, backgroundColor: Colors.black54, child: Icon(Icons.mic, color: Colors.amber, size: 20)),
                        ),
                        const SizedBox(height: 4),
                        const Text('مايك فارغ', style: TextStyle(color: Colors.white70, fontSize: 10)),
                      ],
                    )),
                  ),
                ),
                // شات البث الحي لحظياً
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('live_chat_messages').orderBy('timestamp', descending: true).limit(30).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Colors.pink));
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          reverse: true,
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final data = docs[index].data() as Map<String, dynamic>;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                '${data['sender'] ?? 'مستخدم'}: ${data['text'] ?? ''}',
                                style: const TextStyle(color: Colors.white, fontSize: 13),
                                textDirection: TextDirection.rtl,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                // شريط التفاعل السفلي (شرسد الرسائل والهدايا)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'تحدث في الغرفة...',
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.black54,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.pink,
                        child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 18), onPressed: _sendMessage),
                      ),
                      const SizedBox(width: 6),
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: IconButton(
                          icon: const Icon(Icons.card_giftcard, color: Colors.black, size: 18),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال هدية افتراضية 🎁 وتناقص الماسات!')));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
