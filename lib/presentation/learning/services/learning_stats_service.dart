import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningStatsService {
  static const String _wordsLearnedKey = 'words_learned';
  static const String _daysStreakKey = 'days_streak';
  static const String _lastLearnedDateKey = 'last_learned_date';

  final SharedPreferences _prefs;

  LearningStatsService(this._prefs) {
    // clearStats();
    final wordsLearned = _prefs.getStringList(_wordsLearnedKey) ?? [];
    // Initialize with empty list if not already set
    if (!_prefs.containsKey(_wordsLearnedKey)) {
      _prefs.setStringList(_wordsLearnedKey, []);

      print(wordsLearned);
    }
    print(wordsLearned);
  }

  // Get current stats
  Future<LearningStats> getStats() async {
    final wordsLearned = _prefs.getStringList(_wordsLearnedKey) ?? [];
    final daysStreak = _prefs.getInt(_daysStreakKey) ?? 0;
    clearStats();
    return LearningStats(
      learningRate: 0.0, // We'll implement this later
      totalWordsLearned: wordsLearned.length,
      totalDaysLearned: daysStreak,
    );
  }

  // Add a new word to learned list
  Future<void> addLearnedWord(String word) async {
    final wordsLearned = _prefs.getStringList(_wordsLearnedKey) ?? [];
    if (!wordsLearned.contains(word)) {
      wordsLearned.add(word);
      await _prefs.setStringList(_wordsLearnedKey, wordsLearned);
    }
  }

  // Add method to clear stats
  Future<void> clearStats() async {
    await _prefs.remove(_wordsLearnedKey);
    await _prefs.remove(_daysStreakKey);
    await _prefs.remove(_lastLearnedDateKey);
    // Re-initialize with empty list
    await _prefs.setStringList(_wordsLearnedKey, []);
  }
}
