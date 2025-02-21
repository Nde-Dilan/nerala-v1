import 'package:flutter/material.dart';
import 'package:other_screens/data/models/main/dictionary_model.dart';
import 'package:other_screens/presentation/dictionary/pages/tts_button.dart';

class DictionaryCard extends StatelessWidget {
  final DictionaryEntry entry;

  const DictionaryCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.green, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.character,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    entry.translation,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              entry.word,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            TextToSpeechButton(word:entry.word),
          ],
        ),
      ),
    );
  }
}
