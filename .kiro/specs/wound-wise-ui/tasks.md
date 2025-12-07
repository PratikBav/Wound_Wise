# Implementation Plan

- [x] 1. Set up project dependencies and assets




  - Add required packages to pubspec.yaml: image_picker, permission_handler
  - Configure assets section in pubspec.yaml for logo image
  - Add platform-specific permission configurations (AndroidManifest.xml, Info.plist)


  - _Requirements: 1.1, 3.2, 4.2_

- [ ] 2. Create theme configuration and color system

  - Create lib/theme/app_colors.dart with logo-derived color constants
  - Create lib/theme/app_theme.dart with ThemeData configuration
  - Define primary, secondary, background, and text colors
  - Configure button themes, text themes, and AppBar theme
  - _Requirements: 7.1, 7.2, 7.3, 7.4_

- [x]\* 2.1 Write property test for theme consistency



  - **Property 6: Theme color consistency**
  - **Validates: Requirements 7.1, 7.2, 7.4**

- [ ] 3. Create folder structure and constants



  - Create lib/screens/ directory
  - Create lib/widgets/ directory
  - Create lib/services/ directory
  - Create lib/constants/app_constants.dart with timing and text constants
  - _Requirements: 8.1, 8.2, 8.3, 8.4_

- [ ] 4. Implement reusable widgets

  - Create lib/widgets/image_input_button.dart with icon, label, and onPressed callback
  - Create lib/widgets/loading_indicator.dart with optional message parameter
  - Apply theme colors to both widgets
  - _Requirements: 2.1, 2.4, 5.2_



- [ ]\* 4.1 Write unit tests for reusable widgets

  - Test ImageInputButton renders with correct label and icon
  - Test LoadingIndicator displays message when provided
  - Test theme color application
  - _Requirements: 2.1, 5.2_

- [ ] 5. Implement image service

  - Create lib/services/image_service.dart
  - Implement captureImage() method using ImagePicker
  - Implement pickImageFromGallery() method using ImagePicker
  - Add error handling for null returns (user cancellation)
  - _Requirements: 3.1, 3.3, 4.1, 4.3_

- [ ]\* 5.1 Write property test for image navigation consistency

  - **Property 2: Image input navigation consistency**
  - **Validates: Requirements 3.3, 4.3**

- [ ]\* 5.2 Write property test for cancel operation handling



  - **Property 4: Cancel operation state preservation**
  - **Validates: Requirements 3.5, 4.5**

- [ ]\* 5.3 Write unit tests for image service

  - Test captureImage with mocked ImagePicker
  - Test pickImageFromGallery with mocked ImagePicker
  - Test null handling for cancelled operations
  - _Requirements: 3.1, 4.1_

- [ ] 6. Implement splash screen

  - Create lib/screens/splash_screen.dart as StatefulWidget
  - Add centered logo image display
  - Add "Intelligent Wound Assessment" text below logo
  - Implement 2-3 second timer using Future.delayed
  - Navigate to home screen after timer completes
  - Apply theme colors to background
  - _Requirements: 1.1, 1.2, 1.3, 1.4_



- [ ]\* 6.1 Write property test for splash screen timing

  - **Property 1: Splash screen auto-navigation timing**
  - **Validates: Requirements 1.3**

- [ ]\* 6.2 Write widget tests for splash screen

  - Test logo displays correctly
  - Test tagline text displays correctly
  - Test theme colors applied
  - _Requirements: 1.1, 1.2, 1.4_

- [ ] 7. Implement home screen

  - Create lib/screens/home_screen.dart as StatelessWidget
  - Add AppBar with "WoundWise" title
  - Add "Capture Image" button using ImageInputButton widget
  - Add "Upload from Phone" button using ImageInputButton widget
  - Implement camera button tap handler calling ImageService.captureImage()
  - Implement gallery button tap handler calling ImageService.pickImageFromGallery()
  - Navigate to processing screen on successful image selection
  - Display error SnackBar on permission denial
  - Apply theme colors to all UI elements
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 3.1, 3.4, 4.1, 4.4_



- [ ]\* 7.1 Write property test for permission denial handling

  - **Property 3: Permission denial handling**
  - **Validates: Requirements 3.4, 4.4**

- [ ]\* 7.2 Write widget tests for home screen

  - Test both buttons render correctly
  - Test button tap triggers correct service method
  - Test navigation on successful image selection
  - Test error display on permission denial
  - _Requirements: 2.1, 2.2, 2.3, 3.4, 4.4_

- [ ] 8. Implement processing screen

  - Create lib/screens/processing_screen.dart as StatefulWidget
  - Accept imageFile parameter in constructor
  - Display LoadingIndicator widget with "Analyzing wound image..." message
  - Implement 2-3 second processing simulation using Future.delayed


  - Navigate to output screen after processing completes
  - Apply theme colors to background
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [ ]\* 8.1 Write property test for processing navigation

  - **Property 5: Processing to output navigation**
  - **Validates: Requirements 5.5**

- [ ]\* 8.2 Write widget tests for processing screen

  - Test loading indicator displays
  - Test status message displays correctly
  - Test theme colors applied
  - _Requirements: 5.2, 5.3, 5.4_

- [ ] 9. Implement output screen

  - Create lib/screens/output_screen.dart as StatelessWidget
  - Accept imageFile parameter in constructor
  - Display original image using Image.file() with proper sizing


  - Add "Back to Home" button at bottom
  - Implement back button navigation to home screen
  - Apply theme colors to all UI elements
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [ ]\* 9.1 Write property test for back navigation

  - **Property 7: Back navigation from output**
  - **Validates: Requirements 6.4, 6.5**

- [ ]\* 9.2 Write widget tests for output screen

  - Test image displays correctly
  - Test back button renders
  - Test back button navigation


  - Test theme colors applied
  - _Requirements: 6.2, 6.3, 6.4, 6.5_

- [ ] 10. Update main.dart and configure navigation

  - Update lib/main.dart to use custom theme from app_theme.dart
  - Set splash screen as initial route
  - Configure MaterialApp with theme
  - Update app title to "WoundWise"
  - Remove default counter demo code
  - _Requirements: 1.3, 7.1_

- [x]\* 10.1 Write integration tests for complete user flows




  - Test complete camera flow: Splash → Home → Camera → Processing → Output → Home
  - Test complete gallery flow: Splash → Home → Gallery → Processing → Output → Home
  - Test permission denial flow
  - Test cancel operation flow
  - _Requirements: 1.3, 2.1, 3.3, 4.3, 5.5, 6.5_

- [ ] 11. Add error handling and edge cases

  - Add null safety checks for image file parameters
  - Add navigation fallback if image is null (return to home)
  - Add try-catch blocks around image picker operations
  - Add proper error messages for different failure scenarios
  - _Requirements: 3.4, 3.5, 4.4, 4.5_

- [ ]\* 11.1 Write unit tests for error handling

  - Test null image handling
  - Test navigation fallback
  - Test error message display
  - _Requirements: 3.4, 4.4_

- [ ] 12. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.
