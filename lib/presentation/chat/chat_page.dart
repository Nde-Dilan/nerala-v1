import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:other_screens/common/constants.dart';
import 'package:flutter_markdown/flutter_markdown.dart';  

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: scaffoldBgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Neri AI",
          style: AppTextStyles.h2.copyWith(color: darkColor),
        ),
        leading: BackButton(color: darkColor),
      ),
      body: LlmChatView(
        provider: GeminiProvider(
          model: GenerativeModel(
            model: 'tunedModels/nerala-fbmwo5szq13y',
            apiKey: 'AIzaSyDk-8RIN1xBNt0PUo4uuu-9G4zkbWu3BXg',
          ),
        ),
        style: LlmChatViewStyle(
          backgroundColor: scaffoldBgColor,
          progressIndicatorColor: seedColor,
          userMessageStyle: UserMessageStyle(
            decoration: BoxDecoration(
              color: seedColor,
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTextStyles.body.copyWith(color: Colors.white),
          ),
         llmMessageStyle: LlmMessageStyle(
  icon: Icons.assistant_rounded, // Or Icons.school_rounded for educational context
  iconColor: seedColor,
  iconDecoration: BoxDecoration(
    color: seedColorPalette.shade50,
    shape: BoxShape.circle,
    border: Border.all(
      color: seedColor.withAlpha(20),
      width: 2,
    ),
  ),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: seedColor.withAlpha(10),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  markdownStyle: MarkdownStyleSheet(
    p: AppTextStyles.body,
    code: AppTextStyles.body.copyWith(
      backgroundColor: seedColorPalette.shade50,
      fontFamily: 'monospace',
    ),
    blockquote: AppTextStyles.body.copyWith(
      color: seedColorPalette.shade700,
      fontStyle: FontStyle.italic,
    ),
  ),
),
          chatInputStyle: ChatInputStyle(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: seedColorPalette.shade200),
            ),
            textStyle: AppTextStyles.body,
            hintText: 'Ask me anything about $languageName...',
            hintStyle: TextStyle(color: Colors.grey.shade400),
          ),
          submitButtonStyle: ActionButtonStyle(
            icon: Icons.send_rounded,
          ),
          suggestionStyle: SuggestionStyle(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: seedColorPalette.shade200),
            ),
          ),
          actionButtonBarDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(005),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
        ),
        suggestions: [
          "How do I say 'Hello' in $languageName?",
          "Conjugate 'être' in present tense",
          "Common $languageName expressions",
        ],
        welcomeMessage:
            """Hello! 👋 I'm Neri, your $languageName learning assistant. 
I can help you with: \n
• Translations \n
• Cultural insights \n 
• Grammar explanations \n
• Pronunciation tips \n \n
What would you like to learn today?""",
      ),
    );
  }
}
