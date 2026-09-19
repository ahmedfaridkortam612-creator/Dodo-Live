import 'package:flutter/material.dart';

void main() {
  runApp(const DodiLiveApp());
}

class UserProfileModel {
  static String name = 'مهندس أحمد الملك';
  static String age = '28';
  static String gender = 'ذكر';
  static String country = 'مصر';
  static int diamonds = 45000;
  static String selectedFrame = 'الملكي الذهبي';
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
        scaffoldBackgroundColor: const Color(0xFF0F051D),
      ),
      home: const DodiSplashScreen(),
    );
  }
}

class DodiSplashScreen extends StatefulWidget {
  const DodiSplashScreen({super.key});

  @override
  State<DodiSplashScreen> createState() => _DodiSplashScreenState();
}

class _DodiSplashScreenState extends State<DodiSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainHomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/splash_background.PNG',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final int userLevel = 20;
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> _comments = [
    {
      'name': 'أحمد فرید',
      'text': 'أهلاً بكم في بث Dodi Live الرائع!',
      'level': 40,
    },
    {
      'name': 'محمد علي',
      'text': 'منورين يا شباب أحلى بث.',
      'level': 10,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodi Live - الرئيسية'),
        backgroundColor: Colors.purple.shade900,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'الماس: ${UserProfileModel.diamonds}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color(0xFF2A0845),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, size: 40, color: Colors.white),
                        ),
                        LevelAssetWidget(
                          level: userLevel,
                          assetType: AssetType.profileFrame,
                          size: 90,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            UserProfileModel.name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('المستوى: Lv.$userLevel', style: const TextStyle(color: Colors.amber)),
                          const SizedBox(height: 8),
                          LevelAssetWidget(
                            level: userLevel,
                            assetType: AssetType.badge,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'دردشة الغرفة المباشرة (شريط التعليقات لكل مستوى):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                int commentLevel = comment['level'];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purple.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      LevelAssetWidget(
                        level: commentLevel,
                        assetType: AssetType.badge,
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            SizedBox(
                              height: 35,
                              width: double.infinity,
                              child: LevelAssetWidget(
                                level: commentLevel,
                                assetType: AssetType.banner,
                                size: 35,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                '${comment['name']}: ${comment['text']}',
                                style: const TextStyle(fontSize: 13, color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'اكتب تعليقك في الروم...',
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade700),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      setState(() {
                        _comments.add({
                          'name': UserProfileModel.name,
                          'text': _commentController.text,
                          'level': userLevel,
                        });
                        _commentController.clear();
                      });
                    }
                  },
                  child: const Text('إرسال'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum AssetType { profileFrame, badge, banner }

class LevelAssetWidget extends StatelessWidget {
  final int level;
  final AssetType assetType;
  final double size;

  const LevelAssetWidget({
    super.key,
    required this.level,
    required this.assetType,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    int rowIndex = 0;
    if (level == 1) rowIndex = 0;
    else if (level == 10) rowIndex = 1;
    else if (level == 20) rowIndex = 2;
    else if (level == 30) rowIndex = 3;
    else if (level == 40) rowIndex = 4;

    int colIndex = 0;
    if (assetType == AssetType.profileFrame) colIndex = 0;
    else if (assetType == AssetType.badge) colIndex = 1;
    else if (assetType == AssetType.banner) colIndex = 2;

    double dx = colIndex * 110.0;
    double dy = rowIndex * 110.0;

    return SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(-dx, -dy),
              child: Image.asset(
                'assets/images/levels_sheet.PNG',
                width: 350,
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
