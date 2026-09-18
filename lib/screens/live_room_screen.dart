import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.email ?? 'مستخدم دودو';
    final messageText = _messageController.text.trim();

    _messageController.clear();

    try {
      await FirebaseFirestore.instance.collection('live_chat_messages').add({
        'sender': userName.split('@')[0],
        'text': messageText,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("خطأ في إرسال الرسالة: $e");
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120B22),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      children: const [
                        CircleAvatar(radius: 12, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 14, color: Colors.white)),
                        SizedBox(width: 8),
                        Text('غرفة دودو الحية 🎥', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.black45),
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('live_chat_messages')
                        .orderBy('timestamp', descending: true)
                        .limit(50)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator(color: Colors.pink));
                      }
                      final docs = snapshot.data!.docs;
                      return ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final data = docs[index].data() as Map<String, dynamic>;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${data['sender'] ?? 'مستخدم'}: ${data['text'] ?? ''}',
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black60,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'تحدث في الغرفة...',
                          hintStyle: TextStyle(color: Colors.white60),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.pink),
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
