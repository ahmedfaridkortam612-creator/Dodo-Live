import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/main_home_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/live_room_screen.dart';

void main() {
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
        primarySwatch: Colors.purple,
      ),
      // ابدأ بالشاشة الافتتاحية
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainHomeScreen(),
        '/wallet': (context) => const WalletScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/live_room': (context) => const LiveRoomScreen(),
      },
    );
  }
}
