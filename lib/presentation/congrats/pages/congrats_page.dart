import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

// Models
class AchievementStats {
  final int wordsLearned;
  final double completionPercentage;

  AchievementStats({
    required this.wordsLearned,
    required this.completionPercentage,
  });
}

// Main Screen
class CongratsPage extends StatelessWidget {
  final AchievementStats stats;

  const CongratsPage({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final AchievementStats effectiveStats =
        stats ?? AchievementStats(wordsLearned: 15, completionPercentage: 100);

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: scaffoldBgColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Congratulation!"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            // spacing: 40,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CongratsHeader(),
              const SizedBox(
                height: 40,
              ),
              TrophyImage(),
              const SizedBox(
                height: 40,
              ),
              StatsSection(stats: effectiveStats),
              const SizedBox(
                height: 40,
              ),
              DoneButton(onPressed: () => Navigator.of(context).pop()),
            ],
          ),
        ),
      ),
    );
  }
}

// Components
class CongratsHeader extends StatelessWidget {
  const CongratsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      " You've made it this far! 🎉",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class TrophyImage extends StatelessWidget {
  const TrophyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.emoji_events,
        size: 200,
        color: Colors.amber,
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  final AchievementStats stats;

  const StatsSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatCard(
          label: 'Words',
          value: '${stats.wordsLearned}+',
          borderColor: warningColor,
        ),
        StatCard(
          label: 'Completion',
          value: '${stats.completionPercentage.toStringAsFixed(0)}%',
          borderColor: seedColor,
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color borderColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class DoneButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DoneButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'DONE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
