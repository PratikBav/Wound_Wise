# WoundWise 

**Professional Wound Assessment at Your Fingertips**

WoundWise uses advanced PyramidNet deep learning to instantly analyze wounds from photos, providing medical-grade severity classification, precise measurements, and care recommendations. All processing happens on-device for complete privacy, making professional wound assessment accessible to healthcare providers, caregivers, and patients alike.

![Flutter](https://img.shields.io/badge/Flutter-3.38.4-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10.3-0175C2?logo=dart)
![Gemini](https://img.shields.io/badge/Gemini-2.5%20Flash-4285F4?logo=google)
![License](https://img.shields.io/badge/License-MIT-green)

##  Vision

Making professional wound assessment accessible to everyone - from healthcare providers in hospitals to caregivers at home and patients monitoring their own recovery. WoundWise combines cutting-edge AI technology with medical expertise to deliver instant, accurate wound analysis while maintaining complete privacy through on-device processing.

##  Key Features

###  Advanced AI Analysis

- **PyramidNet Deep Learning**: Medical-grade wound classification
- **Instant Assessment**: Real-time analysis from photos
- **Severity Classification**: Accurate wound severity grading
- **Precise Measurements**: Automated wound size and area calculation
- **Powered by Gemini Flash**: State-of-the-art AI for medical insights

###  Privacy First

- **On-Device Processing**: All analysis happens locally on your device
- **No Data Upload**: Your medical images never leave your phone
- **Complete Privacy**: HIPAA-compliant approach to sensitive medical data
- **Secure Storage**: Images stored only on your device

###  Intelligent Assistance

- **Interactive Chat**: Ask follow-up questions with full context retention
- **First Aid Guidance**: Practical home care steps and temporary measures
- **Medical Recommendations**: Know when to seek professional help
- **Personalized Advice**: Tailored guidance based on wound characteristics

###  For Everyone

- **Healthcare Providers**: Quick triage and documentation in clinical settings
- **Caregivers**: Monitor wound healing progress at home
- **Patients**: Track recovery and understand wound care needs
- **Emergency Response**: Rapid assessment in critical situations

###  User Experience

- **Beautiful UI**: Modern, clean interface with intuitive navigation
- **Gradient Themes**: Professional medical app design
- **Easy Capture**: Take photos or upload from gallery
- **Full-Screen Chat**: Immersive conversation experience
- **Markdown Support**: Formatted, easy-to-read responses

##  Getting Started

### Prerequisites

- Flutter SDK (3.38.4 or higher)
- Dart SDK (3.10.3 or higher)
- Android Studio / Xcode (for mobile development)
- Google Gemini API Key ([Get one here](https://aistudio.google.com/app/apikey))

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/PratikBav/Wound_Wise.git
   cd Wound_Wise
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure API Key**

   Open `lib/config/api_config.dart` and add your Gemini API key:

   ```dart
   class ApiConfig {
     static const String geminiApiKey = 'YOUR_API_KEY_HERE';
     ApiConfig._();
   }
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

##  App Flow

```
Home Screen
    ↓
Camera / Gallery Selection
    ↓
Processing Screen
    ↓
Output Screen (Wound Image)
    ↓
AI Analysis Screen (Chatbot)
```

##  Project Structure

```
lib/
├── config/
│   └── api_config.dart          # API configuration
├── constants/
│   └── app_constants.dart       # App-wide constants
├── models/
│   └── chat_message.dart        # Chat message model
├── screens/
│   ├── splash_screen.dart       # App splash screen
│   ├── home_screen.dart         # Main home screen
│   ├── processing_screen.dart   # Image processing screen
│   ├── output_screen.dart       # Wound image display
│   └── analysis_screen.dart     # AI chatbot screen
├── services/
│   ├── image_service.dart       # Camera/gallery service
│   └── gemini_service.dart      # Gemini AI integration
├── theme/
│   ├── app_colors.dart          # Color palette
│   └── app_theme.dart           # App theme
├── widgets/
│   ├── image_input_button.dart  # Custom button widget
│   └── loading_indicator.dart   # Loading animation
└── main.dart                    # App entry point
```

##  Design

WoundWise uses a carefully crafted color palette derived from the app logo:

- **Dark Blue** (#1E497A) - Primary color
- **Lime Green** (#6CC04A) - Secondary color
- **Teal** (#5AB5AE) - Accent color
- **Light Blue** (#4092C0) - Complementary color

##  AI Technology

### PyramidNet Deep Learning Architecture

WoundWise leverages advanced PyramidNet neural networks specifically trained for medical image analysis:

- **Medical-Grade Classification**: Trained on extensive wound datasets
- **Multi-Scale Analysis**: Captures both fine details and overall wound context
- **Severity Grading**: Automatic classification of wound severity levels
- **Tissue Recognition**: Identifies different tissue types (granulation, necrotic, etc.)
- **Measurement Precision**: Accurate wound size and area calculations

### Gemini 2.5 Flash Integration

Complementing the PyramidNet analysis with conversational AI:

- **Context Retention**: Chat session maintains full conversation history
- **Medical Knowledge**: Trained on extensive medical literature
- **Practical Guidance**: First aid steps and temporary measures
- **Safety First**: Clear warnings and when to seek professional help

### Response Intelligence

- **Initial Analysis**: Detailed, comprehensive wound assessment with measurements
- **Follow-up Questions**: Brief, direct answers (2-4 sentences)
- **Simple Language**: Medical terminology explained in everyday terms
- **Risk Assessment**: Identifies warning signs requiring immediate attention

##  Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  image_picker: ^1.0.7 # Camera and gallery access
  permission_handler: ^11.0.1 # Permission management
  google_generative_ai: ^0.4.7 # Gemini AI integration
  flutter_markdown: ^0.7.7 # Markdown rendering
```

##  Permissions

### Android

- Camera
- Storage (Read/Write)

### iOS

- Camera
- Photo Library

Permissions are automatically requested when needed.

##  Testing

Run tests:

```bash
flutter test
```

##  Platform Support

-  Android
-  iOS
-  Web (Limited - camera access may vary)
-  Desktop (Limited - camera access may vary)

## 🛠️ Development

### Run in debug mode

```bash
flutter run
```

### Build for production

**Android:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

##  Use Cases

### Healthcare Providers

- **Clinical Triage**: Quick initial assessment in busy emergency departments
- **Documentation**: Consistent wound tracking and progress monitoring
- **Patient Education**: Visual aids for explaining wound care
- **Telemedicine**: Remote wound assessment for virtual consultations

### Caregivers

- **Home Care**: Monitor healing progress between doctor visits
- **Elderly Care**: Track chronic wounds in aging patients
- **Post-Surgery**: Monitor surgical site healing
- **Peace of Mind**: Know when professional help is needed

### Patients

- **Self-Monitoring**: Track your own wound healing journey
- **Education**: Understand your wound and proper care
- **Preparation**: Better communicate with healthcare providers
- **Empowerment**: Take an active role in your recovery

##  Medical Disclaimer

**WoundWise is a medical assessment tool for educational and informational purposes.**

- This app provides AI-assisted analysis but does NOT replace professional medical advice, diagnosis, or treatment
- Always consult a qualified healthcare professional for proper diagnosis and treatment plans
- In case of emergency, severe wounds, or signs of infection, seek immediate medical attention
- The AI provides guidance based on visual assessment and should be used as a supplementary tool
- Results should be interpreted by qualified medical professionals
- Not intended for use as a sole diagnostic tool in clinical decision-making

**Privacy & Data:**

- All processing happens on-device
- No medical images are uploaded to external servers
- Users are responsible for secure storage of their medical data
- Complies with medical data privacy standards

##  Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project from [https://github.com/PratikBav/Wound_Wise](https://github.com/PratikBav/Wound_Wise)
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

##  License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

##  Author

Pratik Bav - [@PratikBav](https://github.com/PratikBav)

Project Link: [https://github.com/PratikBav/Wound_Wise](https://github.com/PratikBav/Wound_Wise)

##  Acknowledgments

- Google Gemini AI for powerful language model
- Flutter team for amazing framework
- Medical professionals who provided guidance
- All contributors and testers

##  Support

For support, open an issue in the [GitHub repository](https://github.com/PratikBav/Wound_Wise/issues).
