import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/api_config.dart';

/// Gemini service with chat session for context retention
class GeminiService {
  late final GenerativeModel _model;
  ChatSession? _chatSession;
  
  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: ApiConfig.geminiApiKey,
      systemInstruction: Content.text(
        'You are a practical medical AI assistant for wound care. '
        'Provide actionable advice including first aid and temporary measures. '
        'Balance safety with practical home care guidance. '
        'For follow-up questions: give brief, direct answers (2-4 sentences). '
        'Use simple language and bullet points. '
        'Include what users can do at home AND when to see a doctor. '
        'Only answer wound-related questions.',
      ),
    );
  }

  /// Analyze wound image and start chat session
  Future<String> analyzeWound(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      final prompt = TextPart(
        'Analyze this wound and provide practical guidance in simple language: '
        '1. What you see (appearance, size, condition) '
        '2. Healing stage or concerns '
        '3. First aid steps you can do at home '
        '4. Temporary measures for relief '
        '5. Warning signs that need immediate medical attention '
        '6. When to see a doctor '
        'Be helpful and practical while staying safe. '
        'End with: "⚕️ Consult a healthcare professional for proper diagnosis and treatment."',
      );
      
      final imagePart = DataPart('image/jpeg', imageBytes);
      
      // Start a new chat session with the image
      _chatSession = _model.startChat(history: [
        Content.multi([prompt, imagePart]),
      ]);
      
      // Get initial analysis
      final response = await _chatSession!.sendMessage(
        Content.text('Please analyze the wound image I just shared.')
      );
      
      return response.text ?? 'Unable to analyze image.';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  /// Send text message in the same session (maintains context)
  Future<String> sendMessage(String message) async {
    try {
      if (_chatSession == null) {
        return 'Please analyze an image first.';
      }
      
      final response = await _chatSession!.sendMessage(
        Content.text(message)
      );
      
      return response.text ?? 'No response.';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
