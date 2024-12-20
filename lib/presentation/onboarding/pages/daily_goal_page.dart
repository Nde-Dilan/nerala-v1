import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/widgets/custom_button.dart';
import 'package:other_screens/presentation/onboarding/pages/language_selection_page.dart';

class DailyGoalPage extends StatefulWidget {
  const DailyGoalPage({super.key});

  @override
  State<DailyGoalPage> createState() => _DailyGoalPageState();
}

class _DailyGoalPageState extends State<DailyGoalPage> {
  String? selectedGoal;

  void updateSelectedGoal(String goal) {
    print(goal);
    setState(() {
      selectedGoal = goal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: scaffoldBgColor,

      appBar: AppBar(
              backgroundColor: scaffoldBgColor,

        leading: BackButton(),
        title: Text('Your Daily Goal?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: mediaHeight(context) / 20,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: mediaWidth(context) / 7),
              child: Text(
                "🎯 Regular practice makes perfect! ✨",
                textAlign: TextAlign.center,
                style: AppTextStyles.h2.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            Expanded(
              child: Center(
                child: GoalSelectionScreen(
                  selectedGoal: selectedGoal,
                  onGoalSelected: updateSelectedGoal,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            CustomButton(
              onPressed: selectedGoal == null
                  ? null // Button is disabled when no goal is selected
                  : () {
                      // Handle navigation or next step
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LanguageSelectionPage()));
                    },
              text: 'NEXT',
            ),
          ],
        ),
      ),
    );
  }
}

class GoalSelectionScreen extends StatelessWidget {
  const GoalSelectionScreen({
    super.key,
    required this.selectedGoal,
    required this.onGoalSelected,
  });

  final String? selectedGoal;
  final Function(String) onGoalSelected;

  @override
  Widget build(BuildContext context) {
    final goals = [
      "🌱 Novice - 5 mins/day",
      "⭐ Regular - 10 mins/day",
      "🔥 Bold - 15 mins/day",
      "💪 Intense - 20 mins/day"
    ];

    return ListView.builder(
      itemCount: goals.length,
      itemBuilder: (context, index) {
        return GoalItemWidget(
          goal: goals[index],
          isSelected: selectedGoal == goals[index],
          onTap: () => onGoalSelected(goals[index]),
        );
      },
    );
  }
}

class GoalItemWidget extends StatelessWidget {
  const GoalItemWidget({
    super.key,
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  final String goal;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 19, horizontal: 22),
        margin: EdgeInsets.symmetric(vertical: 19),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2),
          color: isSelected ? Color(0xff31E600) : Colors.white,
        ),
        child: Text(
          goal,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
