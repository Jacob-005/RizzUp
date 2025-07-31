import 'package:dating_app/pages/user%20signup/signup_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsFormPage extends StatefulWidget {
  const DetailsFormPage({super.key});

  @override
  State<DetailsFormPage> createState() => _DetailsFormPageState();
}

class _DetailsFormPageState extends State<DetailsFormPage> {
  // Controllers for form fields
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();

    // Add listeners to validate form on text change
    phoneController.addListener(_checkFormValidity);
    emailController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    // Clean up listeners and controllers
    phoneController.removeListener(_checkFormValidity);
    emailController.removeListener(_checkFormValidity);

    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // Form validation logic
  void _checkFormValidity() {
    final isValid =
        phoneController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        _isValidEmail(emailController.text.trim());

    setState(() {
      _isFormValid = isValid;
    });
  }

  Future<void> sendOtp(String identifier, String targetType) async {
    final url = Uri.parse(
      'http://10.0.2.2:5000/api/send-otp',
    ); // for Android emulator
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier, 'targetType': targetType}),
    );

    if (response.statusCode == 200) {
      print('OTP sent to $targetType');
    } else {
      print('OTP send failed: ${response.body}');
    }
  }

  // Email validation helper
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      // App bar section
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Main content area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  const Text(
                    'Provide us with some\ndetails',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF005B59),
                      height: 1.2,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Phone number field
                  _buildTextField(
                    label: 'Phone number*',
                    controller: phoneController,
                    prefix: '+91',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),

                  // Email field
                  _buildTextField(
                    label: 'Email*',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
          ),

          // Bottom section with disclaimer and button
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  '*Phone no can be changed later with proper procedure',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
                const SizedBox(height: 20),

                // Next button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        _isFormValid
                            ? () async {
                              print('✅ Button pressed');
                              await sendOtp(
                                emailController.text.trim(),
                                "email",
                              );
                              await sendOtp(
                                phoneController.text.trim(),
                                "phone",
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => SignUpVerificationPage(
                                        email: emailController.text.trim(),
                                        phone: phoneController.text.trim(),
                                      ),
                                ),
                              );
                            }
                            : null,

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isFormValid
                              ? const Color(0xFF005B59)
                              : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: _isFormValid ? 2 : 0,
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _isFormValid ? Colors.white : Colors.grey[600],
                        fontFamily: 'Josefin Sans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Custom text field widget builder
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? prefix,
    TextInputType? keyboardType,
    int? maxLength,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4F4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field label
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontFamily: 'Josefin Sans',
              ),
            ),
            // Input field with optional prefix
            Row(
              children: [
                if (prefix != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      prefix,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFC57A96),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Josefin Sans',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    maxLength: maxLength,
                    inputFormatters:
                        keyboardType == TextInputType.phone
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : null,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF005B59),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Josefin Sans',
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
