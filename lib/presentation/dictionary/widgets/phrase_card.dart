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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: seedColorPalette.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {}, // Optional tap handler
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.word,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.character,
                            style: TextStyle(
                              fontSize: 12,
                              color: seedColorPalette.shade700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 9),
                    TextToSpeechButton(
                      word: entry.word,
                      missingWord: entry.translation,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(),
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Icon(Icons.translate, size: 20),
                //     const SizedBox(width: 8),
                //     Expanded(
                //       child: Text(
                //         entry.translation,
                //         style: TextStyle(
                //           fontSize: 15,
                //           color: Colors.grey.shade700,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
