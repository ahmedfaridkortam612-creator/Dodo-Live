import 'package:flutter/material.dart';

class LiveFeedScreen extends StatelessWidget {
  const LiveFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Live Feed Screen',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
