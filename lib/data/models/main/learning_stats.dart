// models/stats_model.dart
class LearningStats {
  final double learningRate;
  final int totalWordsLearned;
  final int totalDaysLearned;

  const LearningStats({
    required this.learningRate,
    required this.totalWordsLearned,
    required this.totalDaysLearned,
  });

  // Factory method to create stats from API response
  factory LearningStats.fromJson(Map<String, dynamic> json) {
    return LearningStats(
      learningRate: json['learningRate'] ?? 0.0,
      totalWordsLearned: json['totalWordsLearned'] ?? 0,
      totalDaysLearned: json['totalDaysLearned'] ?? 0,
    );
  }
}