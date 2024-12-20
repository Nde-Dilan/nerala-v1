// widgets/stats_card.dart
import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:other_screens/presentation/main/methods/pages_method.dart';

class StatsCard extends StatelessWidget {
  final LearningStats stats;

  const StatsCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaWidth(context) / 2,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildStatItem(
            icon: Icons.trending_up,
            value: '${(stats.learningRate * 100).toStringAsFixed(1)}%',
            label: 'Learning Rate',
          ),
          const SizedBox(height: 8),
          buildStatItem(
            icon: Icons.bookmark,
            value: stats.totalWordsLearned.toString(),
            label: 'Words Learned',
          ),
          const SizedBox(height: 8),
          buildStatItem(
            icon: Icons.calendar_today,
            value: stats.totalDaysLearned.toString(),
            label: 'Days Learned',
          ),
        ],
      ),
    );
  }
}
