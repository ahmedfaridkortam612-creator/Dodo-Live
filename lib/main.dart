import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_home_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/live_room_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/friends_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainHomeScreen(),
        '/wallet': (context) => const WalletScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/live_room': (context) => const LiveRoomScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/friends': (context) => const FriendsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
