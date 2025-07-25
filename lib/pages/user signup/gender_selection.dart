import 'package:dating_app/pages/user%20signup/sexual_orientation.dart';
import 'package:flutter/material.dart';

class GenderSelectionPage extends StatefulWidget {
  const GenderSelectionPage({super.key});

  @override
  State<GenderSelectionPage> createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<GenderSelectionPage> {
  // State variables
  String? selectedGender;
  final TextEditingController genderController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female', 'Trans', 'Others'];

  // Methods
  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
      genderController.text = gender;
    });
  }

  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SexualOrientationPage()),
    );
  }

  // Main build method
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
            // Main content section
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title section
                      const Text(
                        "What's your gender?",
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF005B59),
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Gender options section
                      Column(
                        children:
                            genderOptions.map((gender) {
                              bool isSelected = selectedGender == gender;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () => _selectGender(gender),
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
                                      gender,
                                      style: const TextStyle(
                                        fontFamily: 'Josefin Sans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF005B59),
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

            // Bottom button section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedGender != null ? _onNextPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005B59),
                    disabledBackgroundColor: Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: selectedGender != null ? 2 : 0,
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedGender != null
                              ? Colors.white
                              : Colors.grey.shade600,
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

  // Dispose method
  @override
  void dispose() {
    genderController.dispose();
    super.dispose();
  }
}
