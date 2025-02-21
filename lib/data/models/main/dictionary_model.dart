import 'package:other_screens/data/learning/mock/word_building_mock_data.dart';
import 'package:other_screens/data/learning/models/question.dart';

class DictionaryEntry {
  final String character;
  final String word;
  final String translation;

  DictionaryEntry({
    required this.character,
    required this.word,
    required this.translation,
  });

  static List<DictionaryEntry> sampleEntries = allQuestions.map((question) {
    String word = '';
    String translation = '';

    if (question is WordBuildingQuestion) {
      word = question.targetWord;
      translation = question.meaning ?? '';
    } else if (question is FillInBlankQuestion) {
      word = question.missingWord;
      translation = question.missingWord;
    } else if (question is TrueOrFalseQuestion) {
      word = question.word;
      translation = question.targetWord;
    }

    return DictionaryEntry(
      character: question.category,
      word: word,
      translation: translation,
    );
  }).toSet() // Convert to Set to remove duplicates
  .where((entry) => entry.word.isNotEmpty) // Remove empty entries
  .toList() // Convert back to List
  ..sort((a, b) => a.word.compareTo(b.word)); // Sort alphabetically




  // Add new static field for phrases
  static List<DictionaryEntry> samplePhrases = allQuestions
      .whereType<FillInBlankQuestion>()  // Filter only FillInBlankQuestion
      .map((question) {
        return DictionaryEntry(
          character: question.category ?? '',
          word: question.sentence ?? '',  // Use full sentence as word
          translation: question.missingWord ?? '',
        );
      })
      .where((entry) => 
          entry.word.isNotEmpty && 
          entry.translation.isNotEmpty)  // Filter out empty entries
      .toSet()  // Remove duplicates
      .toList()  // Convert to List
      ..sort((a, b) => a.word.compareTo(b.word));  // Sort alphabetically

}
