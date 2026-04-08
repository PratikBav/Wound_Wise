import 'dart:io';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import 'output_screen.dart';
import '../services/segmentation_service.dart';

/// Processing screen with loading indicator
class ProcessingScreen extends StatefulWidget {
  final File imageFile;

  const ProcessingScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _processImage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Simulate image processing and navigate to output
  Future<void> _processImage() async {
    try {
      // Validate image file exists
      if (!await widget.imageFile.exists()) {
        _showError(AppConstants.imageLoadError);
        return;
      }

      // Artificial delay for effect (minimum 2 seconds)
      await Future.delayed(const Duration(seconds: 2));

      // Run segmentation
      final service = SegmentationService();
      final result = await service.segmentImage(widget.imageFile);
      
      service.dispose();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OutputScreen(
              imageFile: widget.imageFile,
              segmentationMask: result.maskBytes,
              isWoundDetected: result.isWoundDetected,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Processing error: $e');
      if (mounted) {
        _showError('Failed: $e');
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.file(
            widget.imageFile,
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.7),
            colorBlendMode: BlendMode.darken,
          ),
          
          // Scanner Animation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ScannerPainter(_controller.value),
                child: Container(),
              );
            },
          ),
          
          // Text Overlay
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 20, 
                        height: 20, 
                        child: CircularProgressIndicator(
                          color: AppColors.secondary, 
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Analyzing wound structure...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerPainter extends CustomPainter {
  final double value;

  ScannerPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.secondary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final y = value * size.height;

    // Draw scanning line
    canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

    // Draw gradient trail
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.secondary.withValues(alpha: 0.0),
        AppColors.secondary.withValues(alpha: 0.3),
      ],
      stops: const [0.0, 1.0],
    );

    final rect = Rect.fromLTWH(0, y - 100, size.width, 100);
    final trailPaint = Paint()..shader = gradient.createShader(rect);
    
    canvas.drawRect(rect, trailPaint);
  }

  @override
  bool shouldRepaint(covariant ScannerPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
