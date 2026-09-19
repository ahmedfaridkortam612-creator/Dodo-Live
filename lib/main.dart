import 'package:flutter/material.dart';

void main() {
  runApp(const DodiLiveApp());
}

// Global User State Model to manage real user info across the app
class UserProfileModel {
  static String name = 'مهندس أحمد الملك 🦁';
  static String age = '28';
  static String gender = 'ذكر 👨';
  static String country = 'مصر 🇪🇬';
  static int diamonds = 27500;
  static String selectedFrame = 'إطار الأسد الملكي الذهبي 🦁👑';
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
      home: const DodiAuthScreen(),
    );
  }
}

// ====================================================
// 1. شاشة البداية وتسجيل الدخول الاحترافية
// ====================================================
class DodiAuthScreen extends StatelessWidget {
  const DodiAuthScreen({super.key});

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
                const Icon(Icons.live_tv_rounded, size: 95, color: Colors.pinkAccent),
                const SizedBox(height: 16),
                const Text(
                  'Dodi Live',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                ),
                const SizedBox(height: 8),
                const Text(
                  'عالمك الخاص من البث المباشر والمجتمع الفاخر',
                  style: TextStyle(fontSize: 14, color: Colors.white60),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                    ),
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileSetupScreen())),
                    icon: const Icon(Icons.phone_android),
                    label: const Text('تسجيل الدخول برقم الهاتف 📱', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.pinkAccent, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                    ),
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileSetupScreen())),
                    icon: const Icon(Icons.g_mobiledata, size: 30, color: Colors.amber),
                    label: const Text('المتابعة بحساب Google 🌐', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ====================================================
// 2. شاشة إعداد البروفايل الشخصي (الحفظ الحقيقي للبيانات)
// ====================================================
class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController(text: UserProfileModel.name);
  final TextEditingController _ageController = TextEditingController(text: UserProfileModel.age);
  String _selectedGender = UserProfileModel.gender;
  String _selectedCountry = UserProfileModel.country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعداد الملف الشخصي الفاخر ✨'), backgroundColor: const Color(0xFF1A0933)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2A0845), Color(0xFF120B22)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.amber, width: 3)),
                    child: const CircleAvatar(radius: 50, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 60, color: Colors.white)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📸 تم تحديث الصورة الشخصية بنجاح!'))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'اسم المستخدم المستعار', filled: true, fillColor: Colors.black45, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'العمر', filled: true, fillColor: Colors.black45, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              dropdownColor: const Color(0xFF1A0933),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'النوع', filled: true, fillColor: Colors.black45, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)),
              items: ['ذكر 👨', 'أنثى 👩'].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
              onChanged: (val) => setState(() => _selectedGender = val!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              dropdownColor: const Color(0xFF1A0933),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'الدولة', filled: true, fillColor: Colors.black45, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)),
              items: ['مصر 🇪🇬', 'السعودية 🇸🇦', 'الإمارات 🇦🇪', 'الكويت 🇰🇼', 'المغرب 🇲🇦'].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
              onChanged: (val) => setState(() => _selectedCountry = val!),
            ),
            const SizedBox(height: 35),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26))),
                onPressed: () {
                  setState(() {
                    UserProfileModel.name = _nameController.text.trim();
                    UserProfileModel.age = _ageController.text.trim();
                    UserProfileModel.gender = _selectedGender;
                    UserProfileModel.country = _selectedCountry;
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DodiMainHomeScreen()));
                },
                child: const Text('حفظ والانتقال للمجتمع 🚀', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
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
  final List<Map<String, String>> _rooms = [
    {'title': 'غرفة الملوك والنجوم والتحديات ✨', 'host': 'استريمر أحمد', 'viewers': '1.5K', 'category': 'تحديات'},
    {'title': 'جلسة طرب وأغاني طربية 🎤', 'host': 'سارة الملكية', 'viewers': '890', 'category': 'موسيقى'},
    {'title': 'سحب الماس الكبرى (Gates) 💎', 'host': 'الكابتن رامي', 'viewers': '4.1K', 'category': 'ألعاب'},
    {'title': 'دردشة حرة وسوالف ليلية 🌙', 'host': 'نوران السعيد', 'viewers': '620', 'category': 'دردشة'},
  ];

  void _addNewRoom(String title, String category) {
    setState(() {
      _rooms.insert(0, {'title': title, 'host': '${UserProfileModel.name} (أنت)', 'viewers': '1', 'category': category});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      RoomsFeedTab(rooms: _rooms, onAddRoom: _addNewRoom, onChargeRequested: () => setState(() => _currentIndex = 2)),
      const LeaderboardTab(),
      ProfileWalletTab(onStateChanged: () => setState(() {})),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodi Live 🌟', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: const Color(0xFF1A0933),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.amber, size: 26),
            tooltip: 'لوحة التحكم والشحن',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDepositScreen())),
          ),
        ],
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'البروفايل والمحفظة 👑'),
        ],
      ),
    );
  }
}

// ====================================================
// 3. لوحة تحكم الأدمن لشحن الرصيد الفوري بالـ ID
// ====================================================
class AdminDepositScreen extends StatefulWidget {
  const AdminDepositScreen({super.key});

  @override
  State<AdminDepositScreen> createState() => _AdminDepositScreenState();
}

class _AdminDepositScreenState extends State<AdminDepositScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;

  void _processDeposit() async {
    if (_userIdController.text.trim().isEmpty || _amountController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      UserProfileModel.diamonds += int.tryParse(_amountController.text) ?? 0;
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✅ تمت إضافة ${_amountController.text} ماسة بنجاح للـ ID: ${_userIdController.text}')));
    _userIdController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم الأدمن (شحن فوري) ⚡'), backgroundColor: const Color(0xFF1A0933)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2A0845), Color(0xFF120B22)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('شحن رصيد المستخدمين يدوياً بالـ ID', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('أدخل معرف المستخدم وكمية الماسات بعد التحويل المالي:', style: TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 20),
              TextField(
                controller: _userIdController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: 'معرف المستخدم (User ID)', filled: true, fillColor: Colors.black45, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: 'كمية الألماس المراد إضافتها', filled: true, fillColor: Colors.black45, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  onPressed: _isLoading ? null : _processDeposit,
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('تنفيذ الشحن الفوري 🚀', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
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
      {'rank': 5, 'name': UserProfileModel.name, 'diamonds': '${UserProfileModel.diamonds}', 'color': Colors.white70},
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
                        CircleAvatar(radius: 18, backgroundColor: item['color'], child: Text('${item['rank']}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        const SizedBox(width: 16),
                        Expanded(child: Text(item['name'], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
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
  final List<Map<String, String>> rooms;
  final Function(String, String) onAddRoom;
  final VoidCallback onChargeRequested;

  const RoomsFeedTab({super.key, required this.rooms, required this.onAddRoom, required this.onChargeRequested});

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
              TextField(controller: titleController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: 'عنوان الغرفة', hintStyle: TextStyle(color: Colors.white54))),
              const SizedBox(height: 16),
              const Text('اختر التصنيف:', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['تحديات', 'ألعاب', 'موسيقى', 'دردشة'].map((cat) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: selectedCategory == cat ? Colors.pink : Colors.black45),
                    onPressed: () => selectedCategory = cat,
                    child: Text(cat, style: const TextStyle(color: Colors.white, fontSize: 11)),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Colors.white54))),
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
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('افتح غرفتك', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      onPressed: () => _showCreateRoomDialog(context),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: onChargeRequested,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.purple.withOpacity(0.4), borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            const Icon(Icons.diamond, color: Colors.amber, size: 14),
                            const SizedBox(width: 4),
                            Text('${UserProfileModel.diamonds}', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 2),
                            const Icon(Icons.add_circle, color: Colors.pinkAccent, size: 12),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.85),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DodiRoomScreen(roomTitle: room['title']!))),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF2A0845), Color(0xFF160B28)], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
                          const Center(child: Icon(Icons.mic_external_on, size: 40, color: Colors.amber)),
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

// ====================================================
// 4. البروفايل الشخصي الحقيقي وتخصيص الإطارات الملكية مرتبة
// ====================================================
class ProfileWalletTab extends StatefulWidget {
  final VoidCallback onStateChanged;
  const ProfileWalletTab({super.key, required this.onStateChanged});

  @override
  State<ProfileWalletTab> createState() => _ProfileWalletTabState();
}

class _ProfileWalletTabState extends State<ProfileWalletTab> {
  void _showFramesDialog(BuildContext context) {
    final List<Map<String, dynamic>> frames = [
      {'name': 'إطار الأسد الملكي الذهبي 🦁👑', 'color': Colors.amber, 'desc': 'الأفخم والأكثر هيبة (VIP الأعلى)'},
      {'name': 'إطار التنانين المزدوجة النارية 🐉🔥', 'color': Colors.blueAccent, 'desc': 'تصميم أسطوري خاص بالملوك'},
      {'name': 'إطار الـ Admin الفاخر ⚡', 'color': Colors.redAccent, 'desc': 'مخصص لإدارة التطبيق العليا'},
      {'name': 'إطار الأجنحة الملكية الوردية ✨', 'color': Colors.purpleAccent, 'desc': 'للداعمين الكبار بالمستويات العليا'},
      {'name': 'إطار مستويات البرونزية (Lv.1 - 10) 🥉', 'color': Colors.brown, 'desc': 'مستوى البداية والتدرج'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0933),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 380,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('تخصيص الإطارات الملكية المرتبة 👑', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 6),
              const Text('اختر الإطار الأسطوري ليظهر على بروفايلك:', style: TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: frames.length,
                  itemBuilder: (context, index) {
                    final frame = frames[index];
                    bool isSelected = UserProfileModel.selectedFrame == frame['name'];
                    return ListTile(
                      leading: CircleAvatar(backgroundColor: frame['color'] as Color, child: const Icon(Icons.star, color: Colors.black)),
                      title: Text(frame['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      subtitle: Text(frame['desc'] as String, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: isSelected ? Colors.green : Colors.pink),
                        onPressed: () {
                          setState(() {
                            UserProfileModel.selectedFrame = frame['name'];
                          });
                          widget.onStateChanged();
                          Navigator.pop(context);
                        },
                        child: Text(isSelected ? 'مفعل ✓' : 'استخدام', style: const TextStyle(fontSize: 11)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.amber, width: 3)),
                ),
                const CircleAvatar(radius: 48, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 55, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 16),
            Text(UserProfileModel.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Text('العمر: ${UserProfileModel.age} | النوع: ${UserProfileModel.gender} | الدولة: ${UserProfileModel.country}', style: const TextStyle(color: Colors.white60, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.amber)),
              child: Text('وسام SVIP أسطوري ✨ | ${UserProfileModel.selectedFrame}', style: const TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.pinkAccent), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), padding: const EdgeInsets.symmetric(vertical: 12)),
                icon: const Icon(Icons.star, color: Colors.amber),
                label: const Text('تغيير الإطار الملكي والأوسمة 🎨', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () => _showFramesDialog(context),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.purple.withOpacity(0.3), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber.withOpacity(0.6), width: 1.5)),
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
                          const Text('رصيد الألماس 💎', style: TextStyle(color: Colors.white60, fontSize: 12)),
                          Text('${UserProfileModel.diamonds} ماسة', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      setState(() {
                        UserProfileModel.diamonds += 15000;
                      });
                      widget.onStateChanged();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('⚡ تم شحن 15,000 ماسة بنجاح!')));
                    },
                    child: const Text('شحن فوري ⚡', style: TextStyle(fontWeight: FontWeight.bold)),
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

// ====================================================
// 5. غرفة البث مع الهدايا المتحركة وشرايط الإعلانات المتحركة
// ====================================================
class DodiRoomScreen extends StatefulWidget {
  final String roomTitle;
  const DodiRoomScreen({super.key, required this.roomTitle});

  @override
  State<DodiRoomScreen> createState() => _DodiRoomScreenState();
}

class _DodiRoomScreenState extends State<DodiRoomScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<String> _messages = [
    'أهلاً بالجميع في الغرفة التفاعلية الأسطورية 👑',
    'استعدوا لمسابقات وهدايا القصور الطائرة الآن! 🏰',
  ];
  String? _animatedGlobalBanner;

  void _send() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      _messages.add('${UserProfileModel.name}: ${_msgController.text.trim()}');
      _msgController.clear();
    });
  }

  void _showGiftsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0933),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('إرسال الهدايا المتحركة الفخمة 🎁✨', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Row(
                    children: [
                      const Icon(Icons.diamond, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('${UserProfileModel.diamonds} ماسة', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildAnimatedGiftItem('🌹 وردة جوري', 100, Colors.pink),
                    _buildAnimatedGiftItem('🏎️ سيارة رياضية', 1000, Colors.blue),
                    _buildAnimatedGiftItem('🏰 القصر الأسطوري', 5000, Colors.amber),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedGiftItem(String giftName, int cost, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (UserProfileModel.diamonds >= cost) {
          setState(() {
            UserProfileModel.diamonds -= cost;
            _animatedGlobalBanner = '🎉 تبريكات ملكية: ${UserProfileModel.name} أرسل ($giftName) المتحركة للغرفة!';
            _messages.add('🎁 أرسلت هدية متحركة: $giftName (-$cost ماسة)');
          });
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) setState(() => _animatedGlobalBanner = null);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('رصيد الألماس غير كافٍ!')));
        }
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(15), border: Border.all(color: color, width: 1.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(giftName.split(' ')[0], style: const TextStyle(fontSize: 32)),
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
          gradient: LinearGradient(colors: [Color(0xFF1A0933), Color(0xFF0F071D)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.pink.withOpacity(0.5))),
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
                                  Text('${UserProfileModel.diamonds}', style: const TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(4, (index) => Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: index == 0 ? Colors.amber : Colors.purpleAccent, width: 2)),
                            child: CircleAvatar(radius: 28, backgroundColor: Colors.black54, child: Icon(index == 0 ? Icons.mic : Icons.mic_none, color: index == 0 ? Colors.amber : Colors.white70, size: 22)),
                          ),
                          const SizedBox(height: 6),
                          Text(index == 0 ? 'مضيف VIP' : 'مايك ${index + 1}', style: TextStyle(color: index == 0 ? Colors.amber : Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12)),
                            child: Text(_messages[index], style: const TextStyle(color: Colors.white, fontSize: 13)),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _msgController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'تحدث وتفاعل مع أساطير الغرفة...',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.black54,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                            ),
                            onSubmitted: (_) => _send(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.black, size: 20), onPressed: _showGiftsDialog, tooltip: 'الهدايا المتحركة'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_animatedGlobalBanner != null)
                Positioned(
                  top: 70,
                  left: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.amber, Colors.deepOrange]),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.6), blurRadius: 20, spreadRadius: 4)],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 24),
                        const SizedBox(width: 10),
                        Expanded(child: Text(_animatedGlobalBanner!, style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold))),
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
