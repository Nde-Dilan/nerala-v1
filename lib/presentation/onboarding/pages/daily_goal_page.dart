import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/bloc/button/button_state.dart';
import 'package:other_screens/common/bloc/button/button_state_cubit.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/widgets/custom_button.dart';
import 'package:other_screens/data/auth/models/user_creation_req.dart';
import 'package:other_screens/domain/auth/usecases/siginup.dart';
import 'package:other_screens/presentation/onboarding/pages/language_selection_page.dart';

Logger _log = Logger('DailyGoal.dart');

class DailyGoalPage extends StatefulWidget {
  const DailyGoalPage({super.key, required this.userCreationReq});
  final UserCreationReq userCreationReq;

  @override
  State<DailyGoalPage> createState() => _DailyGoalPageState();
}

class _DailyGoalPageState extends State<DailyGoalPage> {
  String? selectedGoal;

  void updateSelectedGoal(String goal) {
    _log.info("Goal updated $goal");
    setState(() {
      selectedGoal = goal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonStateCubit(),
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: scaffoldBgColor,
          leading: BackButton(),
          title: Text('Your Daily Goal?'),
        ),
        body: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            // TODO: implement listener
            
          },
          child: Padding(
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
                    style:
                        AppTextStyles.h2.copyWith(fontStyle: FontStyle.italic),
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
                Builder(
                  builder: (context) {
                    return CustomButton(
                      onPressed: selectedGoal == null
                          ? null // Button is disabled when no goal is selected
                          : () {
                              widget.userCreationReq.dailyGoal = selectedGoal;
                    
                              _log.info("User has selected as daily goal: $selectedGoal");
                              // Handle navigation or next step
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                            LanguageSelectionPage(userCreationReq:widget.userCreationReq)));
                            },
                      text: 'NEXT',
                    );
                  }
                ),
              ],
            ),
          ),
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
