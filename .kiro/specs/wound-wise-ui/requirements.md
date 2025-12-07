# Requirements Document

## Introduction

WoundWise is a mobile application designed to assist healthcare professionals and caregivers in wound assessment through intelligent image analysis. The application allows users to capture or upload wound images, process them through an AI model for segmentation, and view the analyzed results. This initial phase focuses on building the core user interface and navigation flow, with AI model integration planned for a subsequent phase.

## Glossary

- **WoundWise Application**: The mobile application system for wound assessment
- **User**: A healthcare professional or caregiver using the application
- **Splash Screen**: The initial screen displayed when the application launches
- **Home Screen**: The main screen providing image input options
- **Processing Screen**: The screen displayed while image analysis is in progress
- **Output Screen**: The screen displaying the segmented wound image results
- **Image Capture**: The process of taking a photo using the device camera
- **Image Upload**: The process of selecting an existing image from device storage
- **App Logo**: The visual brand identity located at assets/images/logo.png
- **Theme Colors**: The color palette derived from the app logo for consistent UI styling

## Requirements

### Requirement 1

**User Story:** As a user, I want to see a branded splash screen when I launch the app, so that I have a professional first impression and understand the app's purpose.

#### Acceptance Criteria

1. WHEN the WoundWise Application launches THEN the system SHALL display a splash screen with the app logo centered on the screen
2. WHEN the splash screen is displayed THEN the system SHALL show the text "Intelligent Wound Assessment" below the app logo
3. WHEN the splash screen has been displayed for 2 to 3 seconds THEN the system SHALL automatically navigate to the home screen
4. WHEN the splash screen is visible THEN the system SHALL use theme colors derived from the app logo for the background and text styling

### Requirement 2

**User Story:** As a user, I want to choose how to provide a wound image, so that I can either capture a new photo or use an existing one from my device.

#### Acceptance Criteria

1. WHEN the home screen loads THEN the system SHALL display two distinct image input options
2. WHEN the home screen is displayed THEN the system SHALL show a "Capture Image" button that triggers the device camera
3. WHEN the home screen is displayed THEN the system SHALL show an "Upload from Phone" button that opens the device gallery
4. WHEN the home screen is visible THEN the system SHALL use theme colors consistent with the app logo for all UI elements
5. WHEN either input option is selected THEN the system SHALL provide clear visual feedback indicating the selection

### Requirement 3

**User Story:** As a user, I want to capture a wound image using my device camera, so that I can immediately assess fresh wounds without saving photos first.

#### Acceptance Criteria

1. WHEN the user taps the "Capture Image" button THEN the system SHALL open the device camera interface
2. WHEN the camera interface is opened THEN the system SHALL request camera permissions if not already granted
3. WHEN the user captures a photo THEN the system SHALL navigate to the processing screen with the captured image
4. WHEN camera permissions are denied THEN the system SHALL display an error message and remain on the home screen
5. WHEN the user cancels the camera operation THEN the system SHALL return to the home screen without navigation

### Requirement 4

**User Story:** As a user, I want to upload an existing wound image from my phone, so that I can analyze previously captured photos.

#### Acceptance Criteria

1. WHEN the user taps the "Upload from Phone" button THEN the system SHALL open the device gallery interface
2. WHEN the gallery interface is opened THEN the system SHALL request storage permissions if not already granted
3. WHEN the user selects an image THEN the system SHALL navigate to the processing screen with the selected image
4. WHEN storage permissions are denied THEN the system SHALL display an error message and remain on the home screen
5. WHEN the user cancels the gallery selection THEN the system SHALL return to the home screen without navigation

### Requirement 5

**User Story:** As a user, I want to see a processing screen after providing an image, so that I understand the system is working on my request.

#### Acceptance Criteria

1. WHEN an image is captured or uploaded THEN the system SHALL navigate to the processing screen
2. WHEN the processing screen is displayed THEN the system SHALL show a loading indicator to communicate ongoing processing
3. WHEN the processing screen is visible THEN the system SHALL use theme colors consistent with the app logo
4. WHEN the processing screen is displayed THEN the system SHALL show appropriate status text such as "Analyzing wound image"
5. WHEN processing completes THEN the system SHALL automatically navigate to the output screen

### Requirement 6

**User Story:** As a user, I want to view the original wound image on the output screen, so that I can see the input that was analyzed (placeholder for future segmented output).

#### Acceptance Criteria

1. WHEN processing completes THEN the system SHALL navigate to the output screen
2. WHEN the output screen is displayed THEN the system SHALL show the original input image as a placeholder for the segmented result
3. WHEN the output screen is visible THEN the system SHALL use theme colors consistent with the app logo for all UI elements
4. WHEN the output screen is displayed THEN the system SHALL provide a button to return to the home screen
5. WHEN the user taps the return button THEN the system SHALL navigate back to the home screen

### Requirement 7

**User Story:** As a user, I want the app to use a consistent color scheme throughout, so that the interface feels cohesive and professional.

#### Acceptance Criteria

1. WHEN any screen is displayed THEN the system SHALL apply theme colors extracted from the app logo
2. WHEN theme colors are applied THEN the system SHALL use them for primary UI elements including buttons and headers
3. WHEN theme colors are applied THEN the system SHALL ensure sufficient contrast for text readability
4. WHEN the app is running THEN the system SHALL maintain consistent color usage across all screens

### Requirement 8

**User Story:** As a developer, I want the app to follow a clear folder structure, so that the codebase is maintainable and scalable.

#### Acceptance Criteria

1. WHEN the project is organized THEN the system SHALL separate screens into a dedicated screens directory
2. WHEN the project is organized THEN the system SHALL separate reusable widgets into a dedicated widgets directory
3. WHEN the project is organized THEN the system SHALL place theme and styling configuration in a dedicated theme directory
4. WHEN the project is organized THEN the system SHALL store constants and configuration values in a dedicated constants directory
5. WHEN new features are added THEN the system SHALL follow the established folder structure conventions
