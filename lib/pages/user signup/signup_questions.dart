// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:dating_app/pages/user%20signup/looking_for.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  // State variables
  int _currentQuestionIndex = 0;
  late List<String?> _selectedOptions;

  // Animation controllers
  late AnimationController _questionAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Theme colors
  final Color primaryColor = Color(0xFF005B59);
  final Color progressActiveColor = Color(0xFFFF6B9D);
  final Color progressInactiveColor = Color(0xFFFFB8D1);

  // Question data
  final List<Map<String, dynamic>> _questions = [
    {
      'title': 'Let\'s get to know you\nmore',
      'question': 'Do you drink?',
      'options': [
        'Not my thing',
        'On special occasions',
        'Socially, on the weekends',
        'Sober curious',
        'Frequently',
      ],
    },
    {
      'title': 'Let\'s get to know you\nmore',
      'question': 'Do you smoke?',
      'options': [
        'Not my thing',
        'On special occasions',
        'Socially, on the weekends',
        'Sober curious',
        'Frequently',
      ],
    },
    {
      'title': 'Let\'s get to know you\nmore',
      'question': 'Do you exercise?',
      'options': ['Very little', 'Often', 'Everyday', 'I\'m too fat to do so'],
    },
    {
      'title': 'Let\'s get to know you\nmore',
      'question': 'Do you have any pet?',
      'options': [
        'Dog',
        'Cat',
        'Bird',
        'Fish',
        'Hamster',
        'Rabbit',
        'Want a pet',
        "Don't have, but love pets",
        'Allergic to pets',
      ],
    },
    {
      'title': 'Let\'s get to know you\nmore',
      'question': 'What communication style do you prefer?',
      'options': [
        'Whatsapp',
        'Phone caller',
        'Video calls',
        'Bad texter',
        'Better in person',
      ],
    },
    {
      'title': 'Let\'s get to know you\nmore',
      'question': "What's your love language?",
      'options': [
        'Compliments',
        'Presents',
        'Thoughtful gestures',
        'Time together',
        'Touch',
        'Other',
        'Not sure yet',
      ],
    },
    {
      'title': 'Let\'s get to know you\nmore',
      'question': "What's your star sign",
      'options': [
        'Capricorn',
        'Aquarius',
        'Pisces',
        'Aries',
        'Taurus',
        'Gemini',
        'Cancer',
        'Leo',
        'Virgo',
        'Libra',
        'Scorpio',
        'Sagittarius',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedOptions = List<String?>.filled(_questions.length, null);

    // Initialize animation controller
    _questionAnimationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    // Setup slide animation
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _questionAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Setup fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _questionAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _questionAnimationController.forward();
  }

  @override
  void dispose() {
    _questionAnimationController.dispose();
    super.dispose();
  }

  // Handle option selection
  void _onOptionSelected(String option) {
    setState(() {
      _selectedOptions[_currentQuestionIndex] = option;
    });
  }

  // Navigate to next question
  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _questionAnimationController.reverse().then((_) {
        setState(() {
          _currentQuestionIndex++;
        });
        _questionAnimationController.forward();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LookingForPage()),
      );
    }
  }

  // Navigate to previous question
  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _questionAnimationController.reverse().then((_) {
        setState(() {
          _currentQuestionIndex--;
        });
        _questionAnimationController.forward();
      });
    }
  }

  // Progress indicator widget
  Widget _buildDotIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _currentQuestionIndex,
      count: _questions.length,
      effect: JumpingDotEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: progressActiveColor,
        dotColor: progressInactiveColor,
        jumpScale: 1.4,
        verticalOffset: 12,
        spacing: 12,
      ),
    );
  }

  // Option button widget
  Widget _buildOptionButton(String option, bool isSelected) {
    return GestureDetector(
      onTap: () {
        _onOptionSelected(option);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          option,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? primaryColor : primaryColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            fontFamily: 'Josefin Sans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final isAnswered = _selectedOptions[_currentQuestionIndex] != null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _currentQuestionIndex > 0 ? _previousQuestion : null,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color:
                          _currentQuestionIndex > 0
                              ? Color(0xFF666666)
                              : Color(0xFFCCCCCC),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Main content area
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // Title section
                    Text(
                      currentQuestion['title'],
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                        height: 1.3,
                        fontFamily: 'Josefin Sans',
                      ),
                    ),
                    SizedBox(height: 30),

                    // Progress indicator section
                    Center(child: _buildDotIndicator()),
                    SizedBox(height: 40),

                    // Question and options section
                    AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentQuestion['question'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2D2D2D),
                                    fontFamily: 'Josefin Sans',
                                  ),
                                ),
                                SizedBox(height: 24),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children:
                                      currentQuestion['options'].map<Widget>((
                                        option,
                                      ) {
                                        bool isSelected =
                                            _selectedOptions[_currentQuestionIndex] ==
                                            option;
                                        return _buildOptionButton(
                                          option,
                                          isSelected,
                                        );
                                      }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),

            // Bottom navigation button
            Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 40),
              child: AnimatedScale(
                scale: isAnswered ? 1.0 : 0.98,
                duration: Duration(milliseconds: 200),
                child: AnimatedOpacity(
                  opacity: isAnswered ? 1.0 : 0.6,
                  duration: Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: () {
                      if (isAnswered) {
                        _nextQuestion();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow:
                            isAnswered
                                ? [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.25),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ]
                                : [],
                      ),
                      child: Center(
                        child: Text(
                          _currentQuestionIndex == _questions.length - 1
                              ? 'Finish'
                              : 'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
