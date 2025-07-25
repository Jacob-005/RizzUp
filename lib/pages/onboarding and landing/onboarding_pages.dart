// ignore_for_file: deprecated_member_use

import 'package:dating_app/pages/onboarding%20and%20landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPages extends StatefulWidget {
  const OnboardingPages({super.key});

  @override
  State<OnboardingPages> createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages>
    with TickerProviderStateMixin {
  // Page Controller and State
  final PageController _controller = PageController();
  int _currentPage = 0;

  // Animation Controllers
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _subtitleController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotateAnimation;
  late Animation<double> _textFadeAnimation;

  // Onboarding Content Data
  final List<Map<String, dynamic>> onboardingData = [
    {
      'title': 'Welcome to\nRizzup',
      'subtitle':
          'Your campus adventure begins here\nConnect with amazing people around you\nMake meaningful connections that last',
      'button': 'Let\'s Explore',
    },
    {
      'title': 'Campus\nConnections',
      'subtitle':
          '100% verified college students only\nSafe, secure, and trustworthy platform\nJoin thousands of happy students',
      'button': 'Sounds Great',
    },
    {
      'title': 'Simple &\nFun',
      'subtitle':
          'Swipe right to show interest\nMatch and start conversations instantly\nMeet your perfect match effortlessly',
      'button': 'I\'m Excited',
    },
    {
      'title': 'Ready to\nSpark Magic?',
      'subtitle':
          'Create your stunning profile\nShowcase your authentic self\nLet the connections begin',
      'button': 'Start My Journey',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  // Animation Initialization
  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _subtitleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoRotateAnimation = Tween<double>(begin: 0.0, end: 0.05).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOutCubic),
    );
  }

  // Animation Sequence
  void _startAnimations() {
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _textController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _subtitleController.forward();
    });
  }

  void _resetSubtitleAnimation() {
    _subtitleController.reset();
    Future.delayed(const Duration(milliseconds: 100), () {
      _subtitleController.forward();
    });
  }

  // Navigation Logic
  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    }
  }

  // Dynamic Subtitle Builder
  Widget _buildDynamicSubtitle(String subtitle) {
    List<String> lines = subtitle.split('\n');
    return Column(
      children:
          lines.asMap().entries.map((entry) {
            int index = entry.key;
            String line = entry.value;

            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.5 + (index * 0.2)),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _subtitleController,
                  curve: Interval(index * 0.2, 1.0, curve: Curves.easeOutBack),
                ),
              ),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _subtitleController,
                    curve: Interval(index * 0.15, 1.0, curve: Curves.easeIn),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    line,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF005B59),
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(color: const Color(0xFFFFE4F4)),

          // Page View Content
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              _resetSubtitleAnimation();
            },
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),

                      // Animated Logo
                      AnimatedBuilder(
                        animation: _logoScaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _logoScaleAnimation.value,
                            child: Transform.rotate(
                              angle:
                                  _logoRotateAnimation.value *
                                  (index % 2 == 0 ? 1 : -1),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 30,
                                      offset: const Offset(0, 15),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.asset(
                                    'images/logo.png',
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.favorite_rounded,
                                        size: 60,
                                        color: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 50),

                      // Title Text
                      FadeTransition(
                        opacity: _textFadeAnimation,
                        child: Text(
                          data['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF005B59),
                            height: 1.1,
                            letterSpacing: -1,
                            fontFamily: 'Josefin Sans',
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Subtitle Content
                      _buildDynamicSubtitle(data['subtitle']),

                      const Spacer(flex: 2),

                      // Page Indicator
                      AnimatedSmoothIndicator(
                        activeIndex: _currentPage,
                        count: onboardingData.length,
                        effect: JumpingDotEffect(
                          activeDotColor: const Color(0xFF005B59),
                          dotColor: const Color(0xFF005B59).withOpacity(0.3),
                          dotHeight: 14,
                          dotWidth: 14,
                          spacing: 20,
                          jumpScale: 2.5,
                          verticalOffset: 25,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Action Button
                      FadeTransition(
                        opacity: _textFadeAnimation,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF005B59),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 22,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 15,
                              shadowColor: Colors.black.withOpacity(0.3),
                            ),
                            onPressed: _nextPage,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['button'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    fontFamily: 'Josefin Sans',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  index == onboardingData.length - 1
                                      ? Icons.rocket_launch_rounded
                                      : Icons.arrow_forward_rounded,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
