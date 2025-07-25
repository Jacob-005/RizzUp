// ignore_for_file: deprecated_member_use

import 'package:dating_app/pages/user%20signup/gender_selection.dart';
import 'package:flutter/material.dart';

class SignUpVerificationPage extends StatefulWidget {
  const SignUpVerificationPage({super.key});

  @override
  State<SignUpVerificationPage> createState() => _SignUpVerificationPageState();
}

class _SignUpVerificationPageState extends State<SignUpVerificationPage> {
  // ============================================================================
  // STATE VARIABLES
  // ============================================================================
  bool isEmailSelected = true;
  bool isSmsSelected = false;
  bool isEmailVerified = false;
  bool isSmsVerified = false;

  final List<TextEditingController> otpControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<FocusNode> otpFocusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  // ============================================================================
  // LIFECYCLE METHODS
  // ============================================================================
  @override
  void initState() {
    super.initState();
    for (var controller in otpControllers) {
      controller.addListener(_updateButtonState);
    }
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.removeListener(_updateButtonState);
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================
  void _updateButtonState() {
    setState(() {});
  }

  bool get _isOtpComplete {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    otpFocusNodes[0].requestFocus();
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Invalid OTP'),
            content: const Text('Please enter a valid 4-digit OTP.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  // ============================================================================
  // EVENT HANDLERS
  // ============================================================================
  void _onEmailTap() {
    setState(() {
      isEmailSelected = true;
      isSmsSelected = false;
    });
  }

  void _onSmsTap() {
    setState(() {
      isEmailSelected = false;
      isSmsSelected = true;
    });
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  void _onVerifyPressed() {
    if (!_isOtpComplete) return;

    String otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length == 4) {
      setState(() {
        if (isEmailSelected) {
          isEmailVerified = true;
        } else if (isSmsSelected) {
          isSmsVerified = true;
        }
      });

      if (isSmsVerified) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GenderSelectionPage()),
        );
      } else if (isEmailVerified) {
        setState(() {
          isEmailSelected = false;
          isSmsSelected = true;
        });
        _clearOtpFields();
      }
    } else {
      _showErrorDialog();
    }
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      // APP BAR SECTION
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
          // MAIN CONTENT SECTION
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER SECTION
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

                  // VERIFICATION METHOD TOGGLE SECTION
                  Row(
                    children: [
                      // EMAIL TOGGLE BUTTON
                      Expanded(
                        child: GestureDetector(
                          onTap: _onEmailTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isEmailSelected
                                      ? (isEmailVerified
                                          ? const Color(
                                            0xFF005B59,
                                          ).withOpacity(0.1)
                                          : const Color(0xFFFFE4F4))
                                      : Colors.white,
                              border: Border.all(
                                color:
                                    isEmailVerified
                                        ? const Color(0xFF005B59)
                                        : (isEmailSelected
                                            ? Colors.pink.shade200
                                            : Colors.grey.shade300),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color:
                                      isEmailVerified
                                          ? const Color(0xFF005B59)
                                          : (isEmailSelected
                                              ? Colors.black
                                              : Colors.grey),
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Josefin Sans',
                                    color:
                                        isEmailVerified
                                            ? const Color(0xFF005B59)
                                            : (isEmailSelected
                                                ? Colors.black
                                                : Colors.grey),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          isEmailVerified
                                              ? const Color(0xFF005B59)
                                              : (isEmailSelected
                                                  ? Colors.pink
                                                  : Colors.grey.shade400),
                                      width: 2,
                                    ),
                                    color:
                                        isEmailVerified
                                            ? const Color(0xFF005B59)
                                            : (isEmailSelected
                                                ? Colors.pink
                                                : Colors.transparent),
                                  ),
                                  child:
                                      isEmailVerified
                                          ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 14,
                                          )
                                          : (isEmailSelected
                                              ? Container(
                                                margin: const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              )
                                              : null),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // SMS TOGGLE BUTTON
                      Expanded(
                        child: GestureDetector(
                          onTap: _onSmsTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSmsSelected
                                      ? (isSmsVerified
                                          ? const Color(
                                            0xFF005B59,
                                          ).withOpacity(0.1)
                                          : const Color(0xFFFFE4F4))
                                      : Colors.white,
                              border: Border.all(
                                color:
                                    isSmsSelected
                                        ? (isSmsVerified
                                            ? const Color(0xFF005B59)
                                            : Colors.pink.shade200)
                                        : Colors.grey.shade300,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sms_outlined,
                                  color:
                                      isSmsSelected
                                          ? (isSmsVerified
                                              ? const Color(0xFF005B59)
                                              : Colors.black)
                                          : Colors.grey,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'SMS',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Josefin Sans',
                                    color:
                                        isSmsSelected
                                            ? (isSmsVerified
                                                ? const Color(0xFF005B59)
                                                : Colors.black)
                                            : Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          isSmsSelected
                                              ? (isSmsVerified
                                                  ? const Color(0xFF005B59)
                                                  : Colors.pink)
                                              : Colors.grey.shade400,
                                      width: 2,
                                    ),
                                    color:
                                        isSmsSelected
                                            ? (isSmsVerified
                                                ? const Color(0xFF005B59)
                                                : Colors.pink)
                                            : Colors.transparent,
                                  ),
                                  child:
                                      isSmsVerified
                                          ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 14,
                                          )
                                          : (isSmsSelected
                                              ? Container(
                                                margin: const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              )
                                              : null),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // OTP INPUT SECTION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E5EA),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: TextField(
                            controller: otpControllers[index],
                            focusNode: otpFocusNodes[index],
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            cursorColor: const Color(0xFF005B59),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF005B59),
                              height: 1.0,
                              fontFamily: 'Josefin Sans',
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                            onChanged: (value) => _onOtpChanged(value, index),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // BOTTOM BUTTON SECTION
          Container(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isOtpComplete ? _onVerifyPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isOtpComplete
                          ? const Color(0xFF005B59)
                          : Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  isEmailSelected && !isEmailVerified
                      ? 'Verify Email'
                      : 'Verify Mobile No.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _isOtpComplete ? Colors.white : Colors.grey.shade600,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
