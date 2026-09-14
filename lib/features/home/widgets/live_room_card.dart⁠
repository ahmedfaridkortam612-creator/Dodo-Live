import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/live_room_summary.dart';

class LiveRoomCard extends StatelessWidget {
  const LiveRoomCard({super.key, required this.room, required this.onTap});

  final LiveRoomSummary room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Cover — placeholder gradient stands in for the cached network
            // thumbnail (wire to room.coverUrl via CachedNetworkImage).
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.surfaceRaised,
                    AppColors.surface,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: _LiveBadge(isPk: room.isPkBattle, isAudio: room.isAudioOnly),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: _ViewerCount(count: room.viewerCount),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.surfaceLine,
                    child: Text(
                      room.hostName.isNotEmpty ? room.hostName[0] : '?',
                      style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      room.hostName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge({required this.isPk, required this.isAudio});
  final bool isPk;
  final bool isAudio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: isPk ? AppColors.pkGradient : AppColors.liveGradient,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAudio)
            const Icon(Icons.graphic_eq, size: 11, color: Colors.white)
          else
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            ),
          const SizedBox(width: 4),
          Text(
            isPk ? 'PK' : 'LIVE',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewerCount extends StatelessWidget {
  const _ViewerCount({required this.count});
  final int count;

  String get _formatted {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
    return '$count';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.visibility, size: 11, color: Colors.white70),
          const SizedBox(width: 3),
          Text(_formatted,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
