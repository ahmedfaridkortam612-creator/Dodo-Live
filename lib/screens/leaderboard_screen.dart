import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF120B22),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A102F),
          title: const Text('لوحة الشرف - دودو لايف 🏆', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'أعلى الداعمين 💎'),
              Tab(text: 'أعلى المذيعين 🎙️'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // تبويب الداعمين
            _buildRankList(isSupporter: true),
            // تبويب المذيعين
            _buildRankList(isSupporter: false),
          ],
        ),
      ),
    );
  }

  Widget _buildRankList({required bool isSupporter}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        // ترتيب المراكز الثلاثة الأولى بألوان مميزة
        Color rankColor = Colors.white70;
        if (index == 0) rankColor = Colors.amber; // الأول ذهبي
        if (index == 1) rankColor = Colors.grey.shade300; // الثاني فضي
        if (index == 2) rankColor = Colors.brown.shade300; // الثالث برونزي

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A102F),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: index < 3 ? rankColor.withOpacity(0.5) : Colors.white10),
          ),
          child: Row(
            children: [
              // رقم المركز
              SizedBox(
                width: 30,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: rankColor, fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 12),
              // صورة المستخدم
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.purple,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              // اسم المستخدم والـ ID
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSupporter ? 'الداعم الملكي #${index + 1}' : 'المذيع المتألق #${index + 1}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isSupporter ? 'أرسل 500k جوهرة' : 'حقق 1.2M نقطة أرباح',
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // أيقونة الجواهر أو العملات
              Row(
                children: [
                  Icon(
                    isSupporter ? Icons.diamond : Icons.monetization_on,
                    color: isSupporter ? Colors.cyanAccent : Colors.amber,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${(10 - index) * 15000}',
                    style: TextStyle(
                      color: isSupporter ? Colors.cyanAccent : Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
