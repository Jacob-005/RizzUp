// home_page.dart
import 'package:dating_app/pages/homepage/home_page_content.dart';
import 'package:dating_app/pages/homepage/app_bar.dart';
import 'package:dating_app/pages/homepage/nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeIndex = 2; // Default to Home tab

  void _onNavItemTap(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  void _onActionTap(String action) {
    // Handle action button taps (like, reject, message)
    // Add your action handling logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: HomePageContent(
              activeIndex: _activeIndex,
              onActionTap: _onActionTap,
            ),
          ),
          CustomNavBar(activeIndex: _activeIndex, onItemTap: _onNavItemTap),
        ],
      ),
    );
  }
}
