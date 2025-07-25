import 'package:dating_app/pages/user%20signup/signup_questions.dart';
import 'package:flutter/material.dart';

class SexualOrientationPage extends StatefulWidget {
  const SexualOrientationPage({super.key});

  @override
  State<SexualOrientationPage> createState() => _SexualOrientationPageState();
}

class _SexualOrientationPageState extends State<SexualOrientationPage> {
  // State variables
  String? selectedOrientation;
  final TextEditingController orientationController = TextEditingController();

  // Available orientation options
  final List<String> orientationOptions = [
    'Straight',
    'Lesbian',
    'Gay',
    'Bisexual',
    'Others',
  ];

  // Selection handler
  void _selectOrientation(String orientation) {
    setState(() {
      selectedOrientation = orientation;
      orientationController.text = orientation;
    });
  }

  // Navigation handler
  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      // App bar section
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF005B59),
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main content area
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header section
                      const Text(
                        "What's your sexual orientation ?",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF005B59),
                          fontFamily: 'Josefin Sans',
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Orientation options list
                      Column(
                        children:
                            orientationOptions.map((orientation) {
                              bool isSelected =
                                  selectedOrientation == orientation;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () => _selectOrientation(orientation),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFE4F4),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? const Color(0xFF005B59)
                                                : Colors.transparent,
                                        width: isSelected ? 3 : 1,
                                      ),
                                    ),
                                    child: Text(
                                      orientation,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF005B59),
                                        fontFamily: 'Josefin Sans',
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom section with next button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      selectedOrientation != null ? _onNextPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005B59),
                    disabledBackgroundColor: Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: selectedOrientation != null ? 2 : 0,
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedOrientation != null
                              ? Colors.white
                              : Colors.grey.shade600,
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
  }

  @override
  void dispose() {
    // Clean up controller
    orientationController.dispose();
    super.dispose();
  }
}
