import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/live_room_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }
  runApp(const DodoLiveApp());
}

class DodoLiveApp extends StatelessWidget {
  const DodoLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dodo Live',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF120B22),
      ),
      home: const LiveRoomScreen(),
    );
  }
}
