// home_page_content.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:ui';

class HomePageContent extends StatelessWidget {
  final int activeIndex;
  final Function(String) onActionTap;

  const HomePageContent({
    super.key,
    required this.activeIndex,
    required this.onActionTap,
  });

  // Navigation configuration for generic pages
  final List<NavItemData> _navItems = const [
    NavItemData(
      label: 'Explore',
      icon: Icons.explore,
      activeIcon: Icons.explore,
    ),
    NavItemData(label: 'Search', icon: Icons.search, activeIcon: Icons.search),
    NavItemData(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    NavItemData(
      label: 'Messages',
      icon: Icons.message_outlined,
      activeIcon: Icons.message,
    ),
    NavItemData(
      label: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: activeIndex == 2 ? _buildHomeContent() : _buildGenericContent(),
    );
  }

  Widget _buildGenericContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _navItems[activeIndex].activeIcon,
            size: 100,
            color: const Color(0xFFFFAFCC),
          ),
          const SizedBox(height: 20),
          Text(
            '${_navItems[activeIndex].label} Page',
            style: const TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'This is the ${_navItems[activeIndex].label.toLowerCase()} section of the app',
            style: const TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage('images/demo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Stack(children: [_buildProfileInfo()]),
          ),
        ),
        _buildOverlappingIcons(),
      ],
    );
  }

  Widget _buildOverlappingIcons() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionIcon(Icons.close, 'reject', false),
          const SizedBox(width: 10),
          _buildActionIcon(Icons.favorite_outline, 'like', true),
          const SizedBox(width: 10),
          _buildActionIcon(Icons.message_outlined, 'message', false),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String action, bool isFavorite) {
    double iconSize = isFavorite ? 85 : 65;
    double iconInnerSize = isFavorite ? 52 : 28;

    return GestureDetector(
      onTap: () => onActionTap(action),
      child: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE4F4),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black, size: iconInnerSize),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Positioned(
      bottom: 55,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Adithyan MC, ',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFE4F4),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(1, 1),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              Text(
                '21',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 29,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFFFFE4F4),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(1, 1),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildGlassTag('BTech'),
              _buildGlassTag('Smokes Never'),
              _buildGlassTag('Drinks Never'),
              _buildGlassTag('Weeb'),
              _buildGlassTag('Valorant'),
              _buildGlassTag('Physical touch'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTag(String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Data model for navigation items
class NavItemData {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const NavItemData({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}
