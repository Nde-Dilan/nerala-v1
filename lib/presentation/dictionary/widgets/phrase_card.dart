import 'package:flutter/material.dart';
import 'package:other_screens/data/models/main/dictionary_model.dart';
import 'package:other_screens/presentation/dictionary/pages/tts_button.dart';
import 'package:other_screens/common/constants.dart';

class PhraseCard extends StatelessWidget {
  final DictionaryEntry entry;

  const PhraseCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: seedColorPalette.shade200, width: 1),
      ),
      child: ExpansionTile(
        title: Text(
          entry.word,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          entry.character, // Category/Topic
          style: TextStyle(
            fontSize: 12,
            color: seedColorPalette.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        trailing: TextToSpeechButton(word: entry.word,missingWord:entry.translation),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.translate, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        entry.translation,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}