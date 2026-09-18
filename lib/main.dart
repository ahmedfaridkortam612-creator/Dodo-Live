import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        scaffoldBackgroundColor: const Color(0xFF0F0817),
      ),
      home: const ProfessionalLiveRoomScreen(),
    );
  }
}

class ProfessionalLiveRoomScreen extends StatefulWidget {
  const ProfessionalLiveRoomScreen({super.key});

  @override
  State<ProfessionalLiveRoomScreen> createState() => _ProfessionalLiveRoomScreenState();
}

class _ProfessionalLiveRoomScreenState extends State<ProfessionalLiveRoomScreen> {
  final TextEditingController _msgController = TextEditingController();

  void _send() async {
    if (_msgController.text.trim().isEmpty) return;
    String text = _msgController.text.trim();
    _msgController.clear();
    try {
      await FirebaseFirestore.instance.collection('live_chat_messages').add({
        'sender': 'مهندس أحمد',
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
          // خلفية تحاكي كاميرا البث المباشر
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2C124A), Color(0xFF0F0817)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Center(
              child: Icon(Icons.live_tv, size: 80, color: Colors.white24),
            ),
          ),
          
          // محتوى الشاشة الاحترافي
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الشريط العلوي (معلومات المضيف والعدد)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.pink.withOpacity(0.5)),
                        ),
                        child: Row(
                          children: const [
                            CircleAvatar(radius: 12, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 14, color: Colors.white)),
                            SizedBox(width: 8),
                            Text('Dodi Live - بث مباشر', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.black45),
                        icon: const Icon(Icons.close, color: Colors.white, size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // صندوق الشات والرسائل الحية
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('live_chat_messages')
                          .orderBy('timestamp', descending: true)
                          .limit(30)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator(color: Colors.pink));
                        }
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          reverse: true,
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final data = docs[index].data() as Map<String, dynamic>;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10),
                              ),
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

                // شريط إرسال الرسائل والهدايا السفلي
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'اكتب تعليقاً...',
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.black54,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: (_) => _send(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.pink,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white, size: 18),
                          onPressed: _send,
                        ),
                      ),
                      const SizedBox(width: 4),
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: IconButton(
                          icon: const Icon(Icons.card_giftcard, color: Colors.black, size: 18),
                          onPressed: () {
                            // زر الهدايا (15000 كوينز لكل 1 دولار)
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
