import 'package:flutter/material.dart';

class GiftSheet extends StatelessWidget {
  const GiftSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة الهدايا الافتراضية بأسماءها وأسعارها
    final List<Map<String, dynamic>> gifts = [
      {'name': 'وردة 🌹', 'price': '10', 'icon': Icons.local_florist, 'color': Colors.pink},
      {'name': 'قلب ❤️', 'price': '50', 'icon': Icons.favorite, 'color': Colors.red},
      {'name': 'خاتم 💍', 'price': '200', 'icon': Icons.diamond_outlined, 'color': Colors.cyan},
      {'name': 'سيارة 🚗', 'price': '1000', 'icon': Icons.directions_car, 'color': Colors.amber},
      {'name': 'قلعة 🏰', 'price': '5000', 'icon': Icons.castle, 'color': Colors.purpleAccent},
      {'name': 'صاروخ 🚀', 'price': '10000', 'icon': Icons.rocket, 'color': Colors.orange},
    ];

    return Container(
      height: 350,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'هدايا دودو لايف المميزة 🎁',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: const [
                  Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                  SizedBox(width: 4),
                  Text('12,450', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.1,
              ),
              itemCount: gifts.length,
              itemBuilder: (context, index) {
                final gift = gifts[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(gift['icon'], color: gift['color'], size: 32),
                      const SizedBox(height: 6),
                      Text(
                        gift['name'],
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.monetization_on, color: Colors.amber, size: 12),
                          const SizedBox(width: 2),
                          Text(
                            gift['price'],
                            style: const TextStyle(color: Colors.amber, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () {
              // إرسال الهدية
              Navigator.pop(context);
            },
            child: const Text('إرسال الهدية الآن', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
