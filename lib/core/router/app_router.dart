import 'package:go_router/go_router.dart';
import '../../features/home/home_shell.dart';
import '../../features/live/live_new_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeShell(),
    ),
    GoRoute(
      path: '/live/new',
      builder: (context, state) => const LiveNewScreen(),
    ),
  ],
);
