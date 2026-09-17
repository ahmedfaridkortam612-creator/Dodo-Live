import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../widgets/gift_sheet.dart';
import '../widgets/mini_games_sheet.dart';

class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  static const int appID = 123456789;
  static const String appSign = "your_app_sign_here";
  
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initZegoCloud();
  }

  void initZegoCloud() async {
    try {
      ZegoEngineProfile profile = ZegoEngineProfile(
        appID,
        ZegoScenario.LiveStreaming,
      );
      await ZegoExpressEngine.createEngineWithProfile(profile);
      setState(() => isConnected = true);
    } catch (e) {
      debugPrint("خطأ في تشغيل محرك البث: $e");
    }
  }

  // إرسال رسالة حية إلى Firestore
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
    ZegoExpressEngine.destroyEngine();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // خلفية البث
          Positioned.fill(
            child: Container(
              color: const Color(0xFF120B22),
              child: const Center(
                child: Icon(Icons.live_tv, color: Colors.white24, size: 80),
              ),
            ),
          ),
          
          // المحتوى والشات الحي من قاعدة البيانات
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // الهيدر العلوي
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

                  // قائمة عرض الرسائل الحية من Firestore
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

                  // الأزرار السفلية وحقل الكتابة
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
                      const SizedBox(width: 8),
                      // زر الألعاب
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.purple.withOpacity(0.8)),
                        icon: const Icon(Icons.games, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const MiniGamesSheet(),
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      // زر الهدايا
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.pinkAccent),
                        icon: const Icon(Icons.card_giftcard, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const GiftSheet(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
