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
                        MaterialPageRoute(builder: (context) => const DodiRoomScreen()),
                      );
                    },
                    child: const Text('دخول الغرفة الحية 🎥', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

class DodiRoomScreen extends StatefulWidget {
  const DodiRoomScreen({super.key});

  @override
  State<DodiRoomScreen> createState() => _DodiRoomScreenState();
}

class _DodiRoomScreenState extends State<DodiRoomScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<String> _messages = [
    'أهلاً بالجميع في غرفة البث الملكية 👑',
    'منور يا ملك الميكات ✨',
    'أرسل هدية ماسية سريعة 💎'
  ];

  void _send() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      _messages.add('أنت: ${_msgController.text.trim()}');
      _msgController.clear();
    });
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
          child: Column(
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
                        children: const [
                          CircleAvatar(radius: 12, backgroundColor: Colors.pink, child: Icon(Icons.star, size: 14, color: Colors.white)),
                          SizedBox(width: 8),
                          Text('غرفة Dodi المميزة 👑', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
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
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم إرسال هدية ماسية في الغرفة 💎🎁')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
