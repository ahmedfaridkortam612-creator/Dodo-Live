import 'package:flutter/material.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120B22),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A102F),
        title: const Text('دودو لايف - الرئيسية 🌟', style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard, color: Colors.amber),
            onPressed: () => Navigator.pushNamed(context, '/leaderboard'),
          ),
          IconButton(
            icon: const Icon(Icons.account_balance_wallet, color: Colors.amber),
            onPressed: () => Navigator.pushNamed(context, '/wallet'),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A102F),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF120B22)),
              accountName: Text('مستخدم دودو لايف', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('dodo@live.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline, color: Colors.white70),
              title: const Text('تعديل الملف الشخصي', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pushNamed(context, '/edit_profile'),
            ),
            ListTile(
              leading: const Icon(Icons.people_outline, color: Colors.white70),
              title: const Text('الأصدقاء والمتابعون', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pushNamed(context, '/friends'),
            ),
            ListTile(
              leading: const Icon(Icons.message_outlined, color: Colors.white70),
              title: const Text('الرسائل والمحادثات', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pushNamed(context, '/messages'),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: Colors.white70),
              title: const Text('الإعدادات', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الغرف النشطة الآن 🔥',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // الانتقال المباشر لشاشة البث الحي الاحترافية
                      Navigator.pushNamed(context, '/live_room');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A102F),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.purple,
                            child: Icon(Icons.live_tv, size: 30, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'غرفة رقم #${index + 1}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'بث مرئي وصوتي مباشر',
                            style: TextStyle(color: Colors.white60, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
