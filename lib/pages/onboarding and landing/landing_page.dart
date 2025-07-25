// ignore_for_file: deprecated_member_use

import 'package:dating_app/pages/login/login_page.dart';
import 'package:dating_app/pages/user%20signup/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  // State variables
  bool _agreeToTerms = false;
  late AnimationController _logoController;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );

    // Start the animations
    _logoController.repeat();
    _slideController.forward();
  }

  @override
  void dispose() {
    // Clean up animation controllers
    _logoController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFE4F4),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Top navigation section
                SlideTransition(
                  position: _slideAnimation,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationFormPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF005B59),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Logo and app name section
                SlideTransition(
                  position: _slideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo container
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(width: 20),

                      // App name text
                      Text(
                        'RizzUp',
                        style: TextStyle(
                          color: const Color(0xFF005B59),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          fontFamily: 'Josefin Sans',
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Welcome message section
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _slideController,
                      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Color(0xFF005B59),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Josefin Sans',
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Find your perfect match at IILM',
                        style: TextStyle(
                          color: Color(0xFF005B59),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Josefin Sans',
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Decorative divider
                const SizedBox(height: 30),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _slideController,
                      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: Container(
                    height: 2,
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white,
                          Colors.transparent,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Login button section
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _slideController,
                      curve: const Interval(0.7, 1.0, curve: Curves.elasticOut),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed:
                          _agreeToTerms
                              ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF005B59),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.phone, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'login with mobile',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Josefin Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Terms and conditions section
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _slideController,
                      curve: const Interval(0.8, 1.0, curve: Curves.elasticOut),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF005B59),
                        checkColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFF005B59),
                          width: 2,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Color(0xFF005B59),
                                fontSize: 14,
                                fontFamily: 'Josefin Sans',
                              ),
                              children: [
                                const TextSpan(text: 'Agree to the '),
                                TextSpan(
                                  text: 'terms and conditions',
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          _showTermsAndConditions(context);
                                        },
                                ),
                                const TextSpan(text: ' to proceed further'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Terms and conditions dialog
  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE4F4),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Dialog header
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 16, 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Close button row
                      Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Color(0xFF005B59),
                                size: 20,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.3),
                                shape: const CircleBorder(),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Dialog title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.description_rounded,
                            color: const Color(0xFF005B59),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF005B59),
                                fontFamily: 'Josefin Sans',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Dialog content
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSection(
                            'Effective Date',
                            '10-07-2025\n\nWelcome to Rizzup! By accessing or using our app, you agree to be bound by these Terms and Conditions. If you do not agree, please do not use the app.',
                            Icons.calendar_today_rounded,
                          ),
                          _buildSection(
                            '1. Eligibility',
                            '• You must be at least 18 years old and a verified student of IILM University.\n• You must use your real identity and not impersonate anyone else.',
                            Icons.person_rounded,
                          ),
                          _buildSection(
                            '2. Account Usage',
                            '• You are responsible for keeping your login credentials secure.\n• You agree not to share your account or use someone else\'s account.',
                            Icons.account_circle_rounded,
                          ),
                          _buildSection(
                            '3. Community Guidelines',
                            'To keep things respectful and safe:\n• No hate speech, harassment, nudity, or offensive content.\n• No spamming, fake profiles, or misleading information.\n• Report any suspicious activity through the in-app reporting system.',
                            Icons.group_rounded,
                          ),
                          _buildSection(
                            '4. User Content',
                            '• You own your content (photos, bio, messages), but grant us a non-exclusive, royalty-free license to display it on the app.\n• You are responsible for what you post.',
                            Icons.photo_camera_rounded,
                          ),
                          _buildSection(
                            '5. Matchmaking & Communication',
                            '• We do not guarantee successful matches or dates.\n• Conversations and connections are at users discretion; use caution when meeting people.',
                            Icons.favorite_rounded,
                          ),
                          _buildSection(
                            '6. Privacy',
                            '• We respect your privacy. Your personal information is protected under our Privacy Policy.\n• Data collected may be used to improve features, safety, and user experience.',
                            Icons.shield_rounded,
                          ),
                          _buildSection(
                            '7. Termination',
                            '• We may suspend or terminate accounts that violate these terms without prior notice.\n• You can delete your account anytime from the settings.',
                            Icons.exit_to_app_rounded,
                          ),
                          _buildSection(
                            '8. Liability Disclaimer',
                            '• We are not responsible for any interactions, dates, or conflicts between users.\n• Use the app at your own risk. Always meet in public and stay safe.',
                            Icons.warning_amber_rounded,
                          ),
                          _buildSection(
                            '9. Changes to Terms',
                            'We may update these terms at any time. We will notify users via the app or email.',
                            Icons.update_rounded,
                          ),
                          _buildSection(
                            '10. Contact',
                            'For questions or support, email us at support@rizzup.com',
                            Icons.email_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Dialog footer
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF005B59),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Got it!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Terms section builder widget
  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF005B59).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF005B59), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF005B59),
                    fontFamily: 'Josefin Sans',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF005B59),
              height: 1.5,
              fontFamily: 'Josefin Sans',
            ),
          ),
        ],
      ),
    );
  }
}
