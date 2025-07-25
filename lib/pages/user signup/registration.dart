import 'package:dating_app/pages/user%20signup/details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({super.key});

  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  // Controllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  String? _selectedCourse;
  bool _isFormValid = false;

  final List<String> _btechCourses = [
    'B.Tech(Biotech)',
    'B.Tech(CS)',
    'BBA',
    'Law',
  ];

  @override
  void initState() {
    super.initState();

    // Add listeners to validate form on text change
    firstNameController.addListener(_checkFormValidity);
    lastNameController.addListener(_checkFormValidity);
    _dobController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    // Clean up listeners and controllers
    firstNameController.removeListener(_checkFormValidity);
    lastNameController.removeListener(_checkFormValidity);
    _dobController.removeListener(_checkFormValidity);

    firstNameController.dispose();
    lastNameController.dispose();
    _dobController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  // Form validation logic
  void _checkFormValidity() {
    final isValid =
        firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        _dobController.text.trim().isNotEmpty &&
        _selectedCourse != null;

    setState(() {
      _isFormValid = isValid;
    });
  }

  String _getDisplayText(String course) {
    if (course.length > 15) {
      return '${course.substring(0, 15)}...';
    }
    return course;
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

                  // Name fields row
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'First name*',
                          controller: firstNameController,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildTextField(
                          label: 'Last name*',
                          controller: lastNameController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // DOB and Course fields row
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          label: 'Date of birth*',
                          controller: _dobController,
                          hintText: 'DD / MM / YYYY',
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildDropdownField(
                          label: 'Course*',
                          value: _selectedCourse,
                          items: _btechCourses,
                          hintText: 'Select Course',
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCourse = newValue;
                            });
                            _checkFormValidity();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Place field
                  _buildTextField(
                    label: 'Place (Optional)',
                    controller: _placeController,
                    hintText: 'Enter your place',
                  ),
                ],
              ),
            ),
          ),

          // Bottom section with button
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Next button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        _isFormValid
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsFormPage(),
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
    String? hintText,
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
                        color: Color(0xFF005B59),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      counterText: '',
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        fontFamily: 'Josefin Sans',
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
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

  // Date field widget
  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    String? hintText,
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
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DateInputFormatter(),
                LengthLimitingTextInputFormatter(
                  10,
                ), // DD/MM/YYYY = 10 characters
              ],
              style: const TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 16,
                color: Color(0xFF005B59),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Josefin Sans',
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dropdown field widget
  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required String hintText,
    required Function(String?) onChanged,
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
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                isDense: true,
              ),
              style: const TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF005B59),
              ),
              dropdownColor: const Color(0xFFFFE4F4),
              isExpanded: true,
              hint: Text(
                hintText,
                style: const TextStyle(
                  fontFamily: 'Josefin Sans',
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              items:
                  items.map((String course) {
                    return DropdownMenuItem<String>(
                      value: course,
                      child: Text(
                        course,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'Josefin Sans'),
                      ),
                    );
                  }).toList(),
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((String course) {
                  return Text(
                    _getDisplayText(course),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF005B59),
                    ),
                  );
                }).toList();
              },
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

// Custom date input formatter
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.length <= 2) {
      return newValue;
    } else if (text.length <= 4) {
      return TextEditingValue(
        text: '${text.substring(0, 2)}/${text.substring(2)}',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    } else if (text.length <= 8) {
      return TextEditingValue(
        text:
            '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4)}',
        selection: TextSelection.collapsed(offset: text.length + 2),
      );
    }

    return newValue;
  }
}
