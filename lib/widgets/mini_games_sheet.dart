import 'package:flutter/material.dart';

class MiniGamesSheet extends StatelessWidget {
  const MiniGamesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> games = [
      {'name': 'عجلة الحظ (Lucky Wheel)', 'icon': Icons.pie_chart, 'color': Colors.amber},
      {'name': 'حجر النرد السريع (Dice)', 'icon': Icons.casino, 'color': Colors.pinkAccent},
      {'name': 'صناديق الحظ (Lucky Chest)', 'icon': Icons.card_giftcard, 'color': Colors.cyanAccent},
      {'name': 'سباق الخيل (Horse Race)', 'icon': Icons.sports_score, 'color': Colors.purpleAccent},
    ];

    return Container(
      height: 320,
      decoration: const BoxDecoration(
        color: Color(0xFF1A102F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ألعاب دودو لايف الترفيهية 🎮',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: ListTile(
                    leading: Icon(game['icon'], color: game['color'], size: 28),
                    title: Text(
                      game['name'],
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // تشغيل اللعبة أو فتح نافذتها
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
