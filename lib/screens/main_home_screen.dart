import 'package:flutter/material.dart';
import 'live_room_screen.dart'; // استدعاء شاشة الغرفة اللي عملناها قبل كده

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  // صفحات التطبيق الأساسية تحت الـ Bottom Navigation
  final List<Widget> _screens = [
    const HomeTabContent(),
    const Center(child: Text('قائمة الغرف والدردشة', style: TextStyle(color: Colors.white))),
    const Center(child: Text('إضافة بث / إطلاق غرفة', style: TextStyle(color: Colors.white))),
    const Center(child: Text('الرسائل والإشعارات', style: TextStyle(color: Colors.white))),
    const Center(child: Text('الملف الشخصي والمحفظة', style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120B22), // خلفية داكنة فخمة تناسب البث
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1A102F),
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'الغرف'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 18,
              child: Icon(Icons.add, color: Colors.white),
            ),
            label: 'ابدأ بث',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// محتوى تبويب الرئيسية الاحترافي
class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر العلوي (البحث، الإشعارات، والعملات)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'دودو لايف 🔥',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    // أيقونة شحن العملات
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.amber),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.monetization_on, color: Colors.amber, size: 18),
                          SizedBox(width: 5),
                          Text('1,250', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.search, color: Colors.white, size: 26),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // تصنيفات الأقسام (شائع، بث مرئي، صوتي، مواهب)
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryChip(title: 'الرائج 🔥', isSelected: true),
                  CategoryChip(title: 'فيديو لايف 📹', isSelected: false),
                  CategoryChip(title: 'حفلات صوتية 🎙️', isSelected: false),
                  CategoryChip(title: 'ألعاب 🎮', isSelected: false),
                  CategoryChip(title: 'مسابقات 🏆', isSelected: false),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // شبكة الغرف الحية المتاحة (قالب الغرف الفاخر)
            const Text(
              'البثوث الحية الآن',
              style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // عند الضغط على أي غرفة، يتم الدخول لغرفة البث المباشر
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LiveRoomScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple.shade900.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.pinkAccent.withOpacity(0.5)),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: Colors.black54,
                                child: const Center(
                                  child: Icon(Icons.live_tv, color: Colors.white54, size: 40),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const Positioned(
                            bottom: 8,
                            left: 8,
                            right: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'سهرة طرب وفن مع دودي',
                                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '👤 1.4k مشاهد',
                                  style: TextStyle(color: Colors.white70, fontSize: 10),
                                ),
                              ],
                            ),
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

// عنصر التصنيف الأفقي
class CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryChip({super.key, required this.title, required this.isSelected});

  @build
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.pink : Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
