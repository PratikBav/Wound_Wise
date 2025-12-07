import 'dart:io';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../widgets/loading_indicator.dart';
import 'output_screen.dart';

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

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();
    _processImage();
  }

  /// Simulate image processing and navigate to output
  Future<void> _processImage() async {
    try {
      // Validate image file exists
      if (!await widget.imageFile.exists()) {
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppConstants.imageLoadError),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Simulate processing delay
      await Future.delayed(
        const Duration(seconds: AppConstants.processingDuration),
      );

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OutputScreen(imageFile: widget.imageFile),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.imageLoadError),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: const SafeArea(
          child: LoadingIndicator(
            message: AppConstants.processingMessage,
          ),
        ),
      ),
    );
  }
}
