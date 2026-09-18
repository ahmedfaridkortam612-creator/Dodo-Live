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
                  'منصة البث المباشر والترفيه الفاخرة',
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
                    child: const Text('دخول التطبيق والمنصة 🚀', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

// الشاشة الرئيسية التي تضم قائمة الغرف، زر بدء البث، والمحفظة
class DodiMainHomeScreen extends StatefulWidget {
  const DodiMainHomeScreen({super.key});

  @override
  State<DodiMainHomeScreen> createState() => _DodiMainHomeScreenState();
}

class _DodiMainHomeScreenState extends State<DodiMainHomeScreen> {
  int _currentIndex = 0;
  int _userDiamonds = 5000;
  final List<Map<String, String>> _rooms = [
    {'title': 'غرفة الملوك والنجوم ✨', 'host': 'استريمر أحمد', 'viewers': '1.2K', 'category': 'ترفيه'},
    {'title': 'جلسة طرب وأغاني طربية 🎤', 'host': 'سارة الملكية', 'viewers': '850', 'category': 'موسيقى'},
    {'title': 'مسابقات وتحديات الماس 💎', 'host': 'الكابتن رامي', 'viewers': '3.4K', 'category': 'تحديات'},
    {'title': 'دردشة حرة وسوالف ليلية 🌙', 'host': 'نوران السعيد', 'viewers': '540', 'category': 'دردشة'},
  ];

  void _addNewRoom(String title, String category) {
    setState(() {
      _rooms.insert(0, {
        'title': title,
        'host': 'مهندس أحمد (أنت)',
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
      ProfileWalletTab(
        diamonds: _userDiamonds,
        onCharge: () => setState(() => _userDiamonds += 1000),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'البروفايل والمحفظة 👑'),
        ],
      ),
    );
  }
}

// تبويب قائمة الغرف الحية مع زر بدء بث جديد
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
    String selectedCategory = 'ترفيه';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A0933),
          title: const Text('إطلاق غرفة بث جديدة 🎥', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'عنوان الغرفة (مثلاً: سهرة ملكية)',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 16),
              const Text('اختر التصنيف:', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['ترفيه', 'موسيقى', 'تحديات'].map((cat) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedCategory == cat ? Colors.pink : Colors.black45,
                    ),
                    onPressed: () {
                      selectedCategory = cat;
                    },
                    child: Text(cat, style: const TextStyle(color: Colors.white)),
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
              child: const Text('بدء البث الآن 🚀', style: TextStyle(color: Colors.white)),
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
                const Text('غرف البث النشطة 🔴', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
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
                      label: const Text('ابدأ بثك', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
                            child: Icon(Icons.mic, size: 40, color: Colors.amber),
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

// تبويب المحفظة والبروفايل
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
            const SizedBox(height: 6),
            const Text('ID: 88992211', style: TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 30),
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

// غرفة البث الحي المتكاملة مع المايكات والشات والهدايا
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
    'أهلاً بالجميع في الغرفة الملكية 👑',
    'منور البث يا فنان ✨',
  ];
  late int _userDiamonds;
  String? _activeGiftAnimation;

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
                  const Text('اختر هدية فاخرة 🎁', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
            _activeGiftAnimation = giftName;
            _messages.add('🎁 أرسلت هدية فخمة: $giftName (-$cost ماسة)');
          });
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) setState(() => _activeGiftAnimation = null);
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
                  // الشريط العلوي للغرفة
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

                  // شبكة المايكات (Seats)
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
                              border: Border.all(color: Colors.amber, width: 2),
                            ),
                            child: const CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.black54,
                              child: Icon(Icons.mic, color: Colors.amber, size: 22),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text('مايك ${index + 1}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
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

                  // شريط المحادثة والهدايا السفلي
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _msgController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'تحدث في الغرفة...',
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
                        const SizedBox(width: 6),
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: IconButton(
                            icon: const Icon(Icons.card_giftcard, color: Colors.black, size: 18),
                            onPressed: _showGiftsDialog,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // تأثير الهدية الأسطورية المتحركة في منتصف الشاشة
              if (_activeGiftAnimation != null)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade900.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber, width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.amber.withOpacity(0.5), blurRadius: 20, spreadRadius: 5),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🎁 هدية أسطورية أُرسلت الآن!', style: TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(_activeGiftAnimation!, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
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
