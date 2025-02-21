import 'package:flutter/material.dart';

class TranslatedText extends StatelessWidget {
  final String text;
  final Map<String, String> translations;

  const TranslatedText({
    super.key,
    required this.text,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
   List<TextSpan> buildTextSpans() {
  List<TextSpan> spans = [];
  String remainingText = text;
  
  // Find all keyword positions first
  List<Map<String, dynamic>> matches = [];
  
  translations.forEach((keyword, translation) {
    String lowerText = remainingText.toLowerCase();
    String lowerKeyword = keyword.toLowerCase();
    int startIndex = 0;
    
    while (true) {
      int index = lowerText.indexOf(lowerKeyword, startIndex);
      if (index == -1) break;
      
      matches.add({
        'index': index,
        'keyword': keyword,
        'translation': translation,
        'length': keyword.length
      });
      
      startIndex = index + lowerKeyword.length;
    }
  });
  
  // Sort matches by index to process them in order
  matches.sort((a, b) => a['index'].compareTo(b['index']));
  
  // Process matches in order
  int lastIndex = 0;
  
  for (var match in matches) {
    int currentIndex = match['index'];
    
    // Add text before the keyword
    if (currentIndex > lastIndex) {
      spans.add(TextSpan(
        text: remainingText.substring(lastIndex, currentIndex)
      ));
    }
    
    // Add the keyword with translation
    spans.add(
      TextSpan(
        text: "${match['keyword']} (${match['translation']})",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
    
    lastIndex = currentIndex + match['length'] as int;
  }
  
  // Add remaining text after last keyword
  if (lastIndex < remainingText.length) {
    spans.add(TextSpan(
      text: remainingText.substring(lastIndex)
    ));
  }
  
  return spans;
}


  return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              letterSpacing: 0.3,
            ),
        children: buildTextSpans(),
      ),
    );
  }
}
