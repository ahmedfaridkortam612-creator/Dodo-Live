import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF120B22),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A102F),
          title: const Text('الأصدقاء والمتابعون 👥', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            indicatorColor: Colors.pinkAccent,
            labelColor: Colors.pinkAccent,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'المتابعون (Followers)'),
              Tab(text: 'الأصدقاء (Friends)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // تبويب المتابعين
            _buildUsersList(isFollowing: false),
            // تبويب الأصدقاء
            _buildUsersList(isFollowing: true),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersList({required bool isFollowing}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A102F),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.purple,
              child: Icon(Icons.person, color: Colors.white, size: 26),
            ),
            title: Text(
              'صديق دودو #${index + 1}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'مذيع نشط في الغرف الصوتية والمرئية',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing ? Colors.white24 : Colors.pink,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {},
              child: Text(isFollowing ? 'متبادل' : 'متابعة'),
            ),
          ),
        );
      },
    );
  }
}
