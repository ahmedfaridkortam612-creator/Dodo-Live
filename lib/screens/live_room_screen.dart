import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../widgets/gift_sheet.dart';
import '../widgets/mini_games_sheet.dart';

class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key});

  @localsState
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  // بيانات تجريبية للاتصال بسيرفر البث
  // (تحتاج لاحقاً لتسجيل حساب مجاني على موقع ZegoCloud للحصول على AppID و AppSign خاصين بك)
  static const int appID = 123456789; // استبدلها بالـ AppID الخاص بك
  static const String appSign = "your_app_sign_here"; 
  
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initZegoCloud();
  }

  void initZegoCloud() async {
    // تهيئة محرك البث الحي
    ZegoEngineProfile profile = ZegoEngineProfile(
      appID,
      ZegoScenario.LiveStreaming,
    );
    await ZegoExpressEngine.createEngineWithProfile(profile);
    
    // بدء معاينة الكاميرا أو الانتهاء من الاتصال بالغرفة
    setState(() {
      isConnected = true;
    });
  }

  @override
  void dispose() {
    ZegoExpressEngine.destroyEngine();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // شاشة الكاميرا أو البث الحقيقي
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  'جاري الاتصال بسيرفر البث الحي...',
                  style: TextStyle(color: Colors.white54),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            CircleAvatar(radius: 14, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 16, color: Colors.white)),
                            SizedBox(width: 8),
                            Text('غرفة دودو الحية 🎥', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
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
                            color: Colors.black54,
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

                      // زر الألعاب
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.purple.withOpacity(0.7)),
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

                      // زر الهدايا
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
