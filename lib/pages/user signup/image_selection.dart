// ignore_for_file: avoid_print

import 'package:dating_app/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoUploadPage extends StatefulWidget {
  const PhotoUploadPage({super.key});

  @override
  State<PhotoUploadPage> createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  // State variables
  final ImagePicker _picker = ImagePicker();
  List<File?> selectedImages = List.filled(6, null);

  // Image picker handler
  Future<void> _pickImage(int index) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImages[index] = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // App bar
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
          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page title
                  const Text(
                    'Let us see that ass!!',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF005B59),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'give us some pic to show others how hot you are',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 15,
                      color: Color(0xFF005B59),
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Photo grid
                  _buildPhotoGrid(),
                ],
              ),
            ),
          ),

          // Next button
          Container(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005B59),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Photo grid layout
  Widget _buildPhotoGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildPhotoSlot(0)),
            const SizedBox(width: 15),
            Expanded(child: _buildPhotoSlot(1)),
            const SizedBox(width: 15),
            Expanded(child: _buildPhotoSlot(2)),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: _buildPhotoSlot(3)),
            const SizedBox(width: 15),
            Expanded(child: _buildPhotoSlot(4)),
            const SizedBox(width: 15),
            Expanded(child: _buildPhotoSlot(5)),
          ],
        ),
      ],
    );
  }

  // Individual photo slot
  Widget _buildPhotoSlot(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 0.65,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () => _pickImage(index),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    selectedImages[index] != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            selectedImages[index]!,
                            fit: BoxFit.cover,
                          ),
                        )
                        : CustomPaint(
                          painter: DottedBorderPainter(
                            color: const Color(0xFF005B59),
                            strokeWidth: 2,
                            dashLength: 8,
                            gapLength: 4,
                          ),
                        ),
              ),
            ),

            // Add/Edit button
            Positioned(
              bottom: -16,
              right: -16,
              child: GestureDetector(
                onTap: () => _pickImage(index),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE4F4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    selectedImages[index] != null ? Icons.edit : Icons.add,
                    color: Colors.white,
                    size: 20,
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

// Custom painter for dotted border
class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              strokeWidth / 2,
              strokeWidth / 2,
              size.width - strokeWidth,
              size.height - strokeWidth,
            ),
            const Radius.circular(12),
          ),
        );

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();

    for (final pathMetric in pathMetrics) {
      double distance = 0;

      while (distance < pathMetric.length) {
        final nextDistance = distance + dashLength;
        final segment = pathMetric.extractPath(
          distance,
          nextDistance > pathMetric.length ? pathMetric.length : nextDistance,
        );
        canvas.drawPath(segment, paint);
        distance = nextDistance + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
