import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

// ... app stuff here

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("AI Chat")),
        body: LlmChatView(
          provider: GeminiProvider(
            model: GenerativeModel(
              model: 'tunedModels/nerala-fbmwo5szq13y',
              apiKey: 'AIzaSyDk-8RIN1xBNt0PUo4uuu-9G4zkbWu3BXg',
              
            ),
          ),
        ),
      );
}