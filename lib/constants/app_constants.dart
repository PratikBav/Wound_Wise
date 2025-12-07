/// Application-wide constants
class AppConstants {
  // Timing constants
  static const int splashScreenDuration = 3; // seconds
  static const int processingDuration = 2; // seconds
  
  // Text constants
  static const String appName = 'WoundWise';
  static const String splashTagline = 'Intelligent Wound Assessment';
  static const String homeTitle = 'WoundWise';
  static const String captureImageLabel = 'Capture Image';
  static const String uploadImageLabel = 'Upload from Phone';
  static const String processingMessage = 'Analyzing wound image...';
  static const String backToHomeLabel = 'Back to Home';
  
  // Error messages
  static const String cameraPermissionDenied = 
      'Camera permission is required to capture images';
  static const String storagePermissionDenied = 
      'Storage permission is required to select images';
  static const String cameraUnavailable = 
      'Camera is not available on this device';
  static const String imageLoadError = 
      'Unable to load the selected image';
  
  // Prevent instantiation
  AppConstants._();
}
