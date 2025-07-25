import 'package:dating_app/pages/user%20signup/image_selection.dart';
import 'package:flutter/material.dart';

class LookingForPage extends StatefulWidget {
  const LookingForPage({super.key});

  @override
  State<LookingForPage> createState() => _LookingForPageState();
}

class _LookingForPageState extends State<LookingForPage> {
  // State variables
  String? selectedOption;
  final TextEditingController lookingForController = TextEditingController();

  // Available options for what user is looking for
  final List<String> lookingForOptions = [
    'Long term partner',
    'Fuck-buddy',
    'Situationship',
    'FBW',
    'Someone to do my assignments',
    'Someone to masturbate to',
  ];

  // Handle option selection
  void _selectOption(String option) {
    setState(() {
      selectedOption = option;
      lookingForController.text = option;
    });
  }

  // Navigate to next page
  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoUploadPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // Custom app bar
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

      // Main content
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Page title
                      const Text(
                        "What are you looking for?",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF005B59),
                          height: 1.2,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Options list
                      Column(
                        children:
                            lookingForOptions.map((option) {
                              bool isSelected = selectedOption == option;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () => _selectOption(option),
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
                                      option,
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

            // Next button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption != null ? _onNextPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005B59),
                    disabledBackgroundColor: Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: selectedOption != null ? 2 : 0,
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedOption != null
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

  // Cleanup resources
  @override
  void dispose() {
    lookingForController.dispose();
    super.dispose();
  }
}
