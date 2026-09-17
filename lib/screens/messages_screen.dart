import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120B22),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A102F),
        title: const Text('الرسائل والمحادثات 💬', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8, // عدد المحادثات الوهمية
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
              leading: Stack(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.person, color: Colors.white, size: 28),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF1A102F), width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                'مستخدم دودو لايف #${index + 1}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  'أهلاً بك، هل ستنضم إلى البث المباشر اليوم؟',
                  style: TextStyle(color: Colors.white60, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'منذ 5 د',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  if (index == 0 || index == 2)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              onTap: () {
                // فتح شاشة المحادثة الفردية
              },
            ),
          );
        },
      ),
    );
  }
}
