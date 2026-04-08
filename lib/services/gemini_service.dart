import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';

/// Gemini service with chat session for context retention
class GeminiService {
  GenerativeModel? _model;
  ChatSession? _chatSession;
  
  GeminiService();

  Future<void> _initModel() async {
    if (_model != null) return;
    
    const storage = FlutterSecureStorage();
    final apiKey = await storage.read(key: 'gemini_api_key') ?? ApiConfig.geminiApiKey;
    
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.text(
        'You are a wound care AI. Be extremely concise. '
        'Give direct, short answers. No fluff. '
        'Use bullet points. Max 2-3 sentences per point. '
        'For follow-ups: Answer in < 50 words if possible. '
        'Stop if unsafe and advise doctor.',
      ),
    );
  }

  /// Analyze wound image and start chat session
  Future<String> analyzeWound(File imageFile) async {
    try {
      await _initModel();
      final imageBytes = await imageFile.readAsBytes();
      final prompt = TextPart(
        'Analyze wound. Brief report:\n'
        '1. Severity Score: [number]/10\n'
        '2. Appearance (1 sentence)\n'
        '3. Condition/Stage\n'
        '4. Immediate Home Care (bullet points)\n'
        '5. Medical Warning (when to see doctor)\n'
        'Keep it short and practical. '
        'End with: "⚕️ Consult doctor for diagnosis."',
      );
      
      final imagePart = DataPart('image/jpeg', imageBytes);
      
      // Start a new chat session with the image
      _chatSession = _model!.startChat(history: [
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
      await _initModel();
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
