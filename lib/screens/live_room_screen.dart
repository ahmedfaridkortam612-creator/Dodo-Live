import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../widgets/gift_sheet.dart';
import '../widgets/mini_games_sheet.dart';

class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  // قيم تعريفية لمحرك ZegoCloud للبث المباشر
  static const int appID = 123456789; // استبدلها بالـ AppID الخاص بك من لوحة تحكم Zego
  static const String appSign = "your_app_sign_here"; // استبدلها بالـ AppSign الخاص بك
  
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
      
      setState(() {
        isConnected = true;
      });
    } catch (e) {
      debugPrint("خطأ في تهيئة سيرفر البث: $e");
    }
  }

  @override
  void dispose() {
    ZegoExpressEngine.destroyEngine();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // خلفية البث المباشر (أو الكاميرا)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF120B22),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.live_tv, color: Colors.pinkAccent, size: 70),
                    SizedBox(height: 16),
                    Text(
                      'جاري الاتصال بغرفة البث الحي...',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // واجهة الأزرار العلوية والسفلية (الهدايا، الألعاب، والشات)
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

                  // الأزرار السفلية
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
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'تحدث في الغرفة...',
                              hintStyle: TextStyle(color: Colors.white60),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // زر الألعاب المصغرة
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
                      const SizedBox(width: 8),

                      // زر الهدايا الفخمة
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.pink),
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
