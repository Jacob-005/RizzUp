// navbar.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  NavItem({required this.label, required this.icon, required this.activeIcon});
}

class CustomNavBar extends StatefulWidget {
  final int activeIndex;
  final Function(int) onItemTap;

  const CustomNavBar({
    super.key,
    required this.activeIndex,
    required this.onItemTap,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  // Navigation configuration
  final List<NavItem> _navItems = [
    NavItem(label: 'Explore', icon: Icons.explore, activeIcon: Icons.explore),
    NavItem(label: 'Search', icon: Icons.search, activeIcon: Icons.search),
    NavItem(label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home),
    NavItem(
      label: 'Messages',
      icon: Icons.message_outlined,
      activeIcon: Icons.message,
    ),
    NavItem(
      label: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _expandAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Container(
        height: 80,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: AnimatedBuilder(
          animation: _expandAnimation,
          builder: (context, child) {
            return _buildAdaptiveNavRow();
          },
        ),
      ),
    );
  }

  Widget _buildAdaptiveNavRow() {
    double screenWidth = MediaQuery.of(context).size.width - 40;
    double baseSize = 50;
    double expandedWidth = 100;
    double extraWidth = expandedWidth - baseSize;

    double totalNormalWidth = baseSize * 5;
    double totalExpandedWidth = totalNormalWidth + extraWidth;

    bool needsCompression = totalExpandedWidth > screenWidth;

    if (needsCompression && widget.activeIndex != -1) {
      return _buildCompressedNavRow(screenWidth, baseSize, expandedWidth);
    } else {
      return _buildNormalNavRow();
    }
  }

  Widget _buildCompressedNavRow(
    double screenWidth,
    double baseSize,
    double expandedWidth,
  ) {
    double remainingWidth = screenWidth - expandedWidth;
    double compressedSize = (remainingWidth / 4).clamp(35.0, baseSize);

    List<Widget> navItems = [];

    for (int i = 0; i < 5; i++) {
      bool isActive = widget.activeIndex == i;
      double itemWidth = isActive ? expandedWidth : compressedSize;

      navItems.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: itemWidth,
          child: _buildNavItem(i, isActive, itemWidth),
        ),
      );

      if (i < 4) {
        navItems.add(
          SizedBox(
            width: _calculateSpacing(
              screenWidth,
              expandedWidth,
              compressedSize,
            ),
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: navItems,
    );
  }

  double _calculateSpacing(
    double screenWidth,
    double expandedWidth,
    double compressedSize,
  ) {
    double totalItemWidth = expandedWidth + (compressedSize * 4);
    double remainingSpace = screenWidth - totalItemWidth;
    return (remainingSpace / 4).clamp(4.0, 12.0);
  }

  Widget _buildNormalNavRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(5, (index) {
        bool isActive = widget.activeIndex == index;
        return _buildNavItem(index, isActive, isActive ? 100 : 50);
      }),
    );
  }

  Widget _buildNavItem(int index, bool isActive, double width) {
    double height = 50;

    return GestureDetector(
      onTap: () => widget.onItemTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFAFCC) : Colors.white,
          borderRadius: BorderRadius.circular(isActive ? 16 : height / 2),
          border: Border.all(
            color: isActive ? const Color(0xFFFFAFCC) : const Color(0xFFE0E0E0),
            width: 1,
          ),
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: const Color(0xFFFFAFCC).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: const Offset(1, 1),
                    ),
                  ],
        ),
        child: Center(
          child:
              isActive
                  ? _buildExpandedNavContent(index)
                  : _buildCollapsedNavContent(index, width),
        ),
      ),
    );
  }

  Widget _buildCollapsedNavContent(int index, double width) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Icon(
          _navItems[index].icon,
          color: const Color(0xFFBDBDBD),
          size: width < 40 ? 18 : 24,
        ),
      ),
    );
  }

  Widget _buildExpandedNavContent(int index) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_navItems[index].activeIcon, color: Colors.white, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  _navItems[index].label,
                  style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
