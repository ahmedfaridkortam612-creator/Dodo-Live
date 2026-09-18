import 'package:flutter/material.dart';

void main() {
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
        scaffoldBackgroundColor: const Color(0xFF120B22),
      ),
      home: const DodiLoginScreen(),
    );
  }
}

class DodiLoginScreen extends StatelessWidget {
  const DodiLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A0845), Color(0xFF120B22)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Icon(Icons.live_tv, size: 90, color: Colors.pinkAccent),
                const SizedBox(height: 16),
                const Text(
                  'Dodi Live',
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                ),
                const SizedBox(height: 8),
                const Text(
                  'منصة البث المباشر والمجتمع التفاعلي الفاخر',
                  style: TextStyle(fontSize: 14, color: Colors.white60),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DodiMainHomeScreen()),
                      );
                    },
                    child: const Text('دخول المنصة والمجتمع 🚀', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DodiMainHomeScreen extends StatefulWidget {
  const DodiMainHomeScreen({super.key});

  @override
  State<DodiMainHomeScreen> createState() => _DodiMainHomeScreenState();
}

class _DodiMainHomeScreenState extends State<DodiMainHomeScreen> {
  int _currentIndex = 0;
  int _userDiamonds = 6500;
  final List<Map<String, String>> _rooms = [
    {'title': 'غرفة الملوك والنجوم والتحديات ✨', 'host': 'استريمر أحمد', 'viewers': '1.5K', 'category': 'تحديات'},
    {'title': 'جلسة طرب وأغاني طربية 🎤', 'host': 'سارة الملكية', 'viewers': '890', 'category': 'موسيقى'},
    {'title': 'سحب الماس الكبرى (Gates) 💎', 'host': 'الكابتن رامي', 'viewers': '4.1K', 'category': 'ألعاب'},
    {'title': 'دردشة حرة وسوالف ليلية 🌙', 'host': 'نوران السعيد', 'viewers': '620', 'category': 'دردشة'},
  ];

  void _addNewRoom(String title, String category) {
    setState(() {
      _rooms.insert(0, {
        'title': title,
        'host': 'مهندس أحمد الملك (أنت)',
        'viewers': '1',
        'category': category,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      RoomsFeedTab(
        userDiamonds: _userDiamonds,
        rooms: _rooms,
        onAddRoom: _addNewRoom,
      ),
      const LeaderboardTab(),
      ProfileWalletTab(
        diamonds: _userDiamonds,
        onCharge: () => setState(() => _userDiamonds += 2000),
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1A0933),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'الغرف الحية 🎥'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'المتصدرين 🏆'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'البروفايل والـ VIP 👑'),
        ],
      ),
    );
  }
}

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topSupporters = [
      {'rank': 1, 'name': 'الملك فهد (SVIP) 👑', 'diamonds': '155,400', 'color': Colors.amber},
      {'rank': 2, 'name': 'الشيخ خالد ✨', 'diamonds': '112,200', 'color': Colors.grey.shade300},
      {'rank': 3, 'name': 'عبدالرحمن الفخم 💎', 'diamonds': '85,100', 'color': Colors.brown.shade300},
      {'rank': 4, 'name': 'سلطان الأسطورة', 'diamonds': '60,000', 'color': Colors.white70},
      {'rank': 5, 'name': 'مهندس أحمد الملك', 'diamonds': '52,300', 'color': Colors.white70},
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('قائمة كبار الداعمين (Leaderboard) 🏆', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 6),
            const Text('المنافسة المشتعلة بين أساطير المجتمع هذا الأسبوع', style: TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: topSupporters.length,
                itemBuilder: (context, index) {
                  final item = topSupporters[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: (item['color'] as Color).withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: item['color'],
                          child: Text('${item['rank']}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(item['name'], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.diamond, color: Colors.amber, size: 16),
                            const SizedBox(width: 6),
                            Text(item['diamonds'], style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ],
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

class RoomsFeedTab extends StatelessWidget {
  final int userDiamonds;
  final List<Map<String, String>> rooms;
  final Function(String, String) onAddRoom;

  const RoomsFeedTab({
    super.key,
    required this.userDiamonds,
    required this.rooms,
    required this.onAddRoom,
  });

  void _showCreateRoomDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    String selectedCategory = 'تحديات';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A0933),
          title: const Text('إطلاق غرفة بث تفاعلية 🎥', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'عنوان الغرفة (مثلاً: سهرة تحديات الماس)',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 16),
              const Text('اختر التصنيف:', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['تحديات', 'ألعاب', 'موسيقى', 'دردشة'].map((cat) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedCategory == cat ? Colors.pink : Colors.black45,
                    ),
                    onPressed: () {
                      selectedCategory = cat;
                    },
                    child: Text(cat, style: const TextStyle(color: Colors.white, fontSize: 11)),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  onAddRoom(titleController.text.trim(), selectedCategory);
                  Navigator.pop(context);
                }
              },
              child: const Text('ابدأ البث الآن 🚀', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المجتمع والغرف النشطة 🔴', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('افتح غرفتك', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      onPressed: () => _showCreateRoomDialog(context),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: Colors.purple.withOpacity(0.4), borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          const Icon(Icons.diamond, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text('$userDiamonds', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DodiRoomScreen(roomTitle: room['title']!, diamonds: userDiamonds),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2A0845), Color(0xFF160B28)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.pink.withOpacity(0.3)),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(8)),
                                child: Text(room['category']!, style: const TextStyle(fontSize: 10, color: Colors.white)),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.remove_red_eye, size: 12, color: Colors.white60),
                                  const SizedBox(width: 4),
                                  Text(room['viewers']!, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                                ],
                              ),
                            ],
                          ),
                          const Center(
                            child: Icon(Icons.mic_external_on, size: 40, color: Colors.amber),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(room['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 2),
                              Text('بواسطة: ${room['host']}', style: const TextStyle(fontSize: 11, color: Colors.white60)),
                            ],
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

class ProfileWalletTab extends StatelessWidget {
  final int diamonds;
  final VoidCallback onCharge;
  const ProfileWalletTab({super.key, required this.diamonds, required this.onCharge});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('مهندس أحمد الملك 👑', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.amber)),
              child: const Text('وسام SVIP أسطوري ✨', style: TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.withOpacity(0.6), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.diamond, color: Colors.amber, size: 36),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('رصيد الماسات 💎', style: TextStyle(color: Colors.white60, fontSize: 12)),
                          Text('$diamonds ماسة', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: onCharge,
                    child: const Text('شحن ⚡', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// غرفة البث التفاعلية مع ألعاب المصادفة والهدايا الملكية العائمة
class DodiRoomScreen extends StatefulWidget {
  final String roomTitle;
  final int diamonds;
  const DodiRoomScreen({super.key, required this.roomTitle, required this.diamonds});

  @override
  State<DodiRoomScreen> createState() => _DodiRoomScreenState();
}

class _DodiRoomScreenState extends State<DodiRoomScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<String> _messages = [
    'أهلاً بالجميع في الغرفة التفاعلية الأسطورية 👑',
    'استعدوا لمسابقات وألعاب الحظ الآن! 🎲',
  ];
  late int _userDiamonds;
  String? _activeGlobalAlert;

  @override
  void initState() {
    super.initState();
    _userDiamonds = widget.diamonds;
  }

  void _send() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      _messages.add('أنت: ${_msgController.text.trim()}');
      _msgController.clear();
    });
  }

  // نافذة ألعاب الحظ التفاعلية داخل الغرفة (مثل الألعاب الترفيهية المشتركة)
  void _showMiniGamesDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0933),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ألعاب الغرفة التفاعلية ومسابقات الحظ 🎲', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 6),
              const Text('اختر اللعبة وشارك المايكات حماسة التحدي:', style: TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildGameCard('تحدي الأسد 🦁', 200, Colors.amber),
                  _buildGameCard('سحب الأوليمبس ⚡', 500, Colors.blueAccent),
                  _buildGameCard('عجلة الحظ 🎡', 100, Colors.pinkAccent),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGameCard(String gameName, int cost, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (_userDiamonds >= cost) {
          setState(() {
            _userDiamonds -= cost;
            _activeGlobalAlert = '🎉 مهندس أحمد شارك في ($gameName) وربح مضاعفة الماسات!';
            _messages.add('🎲 شاركت في لعبة ($gameName) وتكلفت (-$cost ماسة)');
          });
          Future.delayed(const Duration(seconds: 4), () {
            if (mounted) setState(() => _activeGlobalAlert = null);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('رصيد الماسات غير كافٍ للمشاركة في اللعبة!')),
          );
        }
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gamepad, color: color, size: 28),
            const SizedBox(height: 8),
            Text(gameName, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text('$cost 💎', style: const TextStyle(color: Colors.amber, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  void _showGiftsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0933),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('اختر هدية ملكية عائمة 🎁', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Row(
                    children: [
                      const Icon(Icons.diamond, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('$_userDiamonds ماسة', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildGiftItem('🌹 وردة ملكية', 100, Colors.pink),
                    _buildGiftItem('🏎️ سيارة رياضية', 500, Colors.blue),
                    _buildGiftItem('🏰 قصر أسطوري', 2000, Colors.amber),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGiftItem(String giftName, int cost, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (_userDiamonds >= cost) {
          setState(() {
            _userDiamonds -= cost;
            _activeGlobalAlert = '👑 إشعار ملكي: مهندس أحمد أرسل هدية ($giftName) للغرفة!';
            _messages.add('🎁 أرسلت هدية فخمة: $giftName (-$cost ماسة)');
          });
          Future.delayed(const Duration(seconds: 4), () {
            if (mounted) setState(() => _activeGlobalAlert = null);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('رصيد الماسات غير كافٍ، قم بالشحن من المحفظة!')),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.6), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(giftName.split(' ')[0], style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(giftName.split(' ').sublist(1).join(' '), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            Text('$cost 💎', style: const TextStyle(color: Colors.amber, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A0933), Color(0xFF0F071D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // الشريط العلوي
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.pink.withOpacity(0.5)),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(radius: 12, backgroundColor: Colors.pink, child: Icon(Icons.star, size: 14, color: Colors.white)),
                              const SizedBox(width: 8),
                              Text(widget.roomTitle, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  const Icon(Icons.diamond, color: Colors.amber, size: 14),
                                  const SizedBox(width: 4),
                                  Text('$_userDiamonds', style: const TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // شبكة المايكات (Seats) مع إظهار ألقاب الـ VIP
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(4, (index) => Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: index == 0 ? Colors.amber : Colors.purpleAccent, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.black54,
                              child: Icon(index == 0 ? Icons.mic : Icons.mic_none, color: index == 0 ? Colors.amber : Colors.white70, size: 22),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(index == 0 ? 'مضيف SVIP' : 'مايك ${index + 1}', style: TextStyle(color: index == 0 ? Colors.amber : Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      )),
                    ),
                  ),

                  // شات الغرفة الحي
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _messages[index],
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // شريط المحادثة وأزرار التفاعل والألعاب والسفلي
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _msgController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'تحدث وتفاعل مع المجتمع...',
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
                          backgroundColor: Colors.purple,
                          child: IconButton(
                            icon: const Icon(Icons.gamepad, color: Colors.amber, size: 18),
                            onPressed: _showMiniGamesDialog,
                            tooltip: 'ألعاب الغرفة',
                          ),
                        ),
                        const SizedBox(width: 6),
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: IconButton(
                            icon: const Icon(Icons.card_giftcard, color: Colors.black, size: 18),
                            onPressed: _showGiftsDialog,
                            tooltip: 'الهدايا الفاخرة',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // تنبيه الهدية أو اللعبة العائم الأسطوري في أعلى/منتصف الشاشة لكل الحضور
              if (_activeGlobalAlert != null)
                Positioned(
                  top: 70,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade900.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber, width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.amber.withOpacity(0.4), blurRadius: 15, spreadRadius: 3),
                      ],
                    ),
                    child: Text(
                      _activeGlobalAlert!,
                      style: const TextStyle(color: Colors.amber, fontSize: 13, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
