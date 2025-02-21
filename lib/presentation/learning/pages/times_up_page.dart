import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:other_screens/presentation/learning/services/learning_stats_service.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeUpStatsPage extends StatefulWidget {
  const TimeUpStatsPage({super.key});

  @override
  State<TimeUpStatsPage> createState() => _TimeUpStatsPageState();
}

class _TimeUpStatsPageState extends State<TimeUpStatsPage> {
  late Future<LearningStats> _statsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = _initializeStats();
  }

  Future<LearningStats> _initializeStats() async {
    final prefs = await SharedPreferences.getInstance();
    final statsService = LearningStatsService(prefs);
    final actualStats = statsService.getStats();
    statsService.clearStats();
    return actualStats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: FutureBuilder<LearningStats>(
          future: _statsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final stats = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Time's Up! Here's your progress:",
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  _buildStatCard(
                    "Words Learned",
                    "${stats.totalWordsLearned}",
                    Icons.school,
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    "Days Streak",
                    "${stats.totalDaysLearned}",
                    Icons.calendar_today,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () =>
                        AppNavigator.pushReplacement(context, HomePage()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: seedColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    child: const Text("Continue to Home"),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: seedColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: seedColor, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.body),
              Text(
                value,
                style: AppTextStyles.h3.copyWith(color: seedColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
