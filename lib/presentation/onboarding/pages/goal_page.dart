import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/bloc/button/button_state.dart';
import 'package:other_screens/common/bloc/button/button_state_cubit.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/widgets/custom_button.dart';
import 'package:other_screens/data/auth/models/user_creation_req.dart';
import 'package:other_screens/presentation/onboarding/pages/daily_goal_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


Logger _log = Logger('GoalPage.dart');

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key, required this.userCreationReq});

  final UserCreationReq userCreationReq;

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  String? selectedGoal;

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_completed_onboarding', true);
  }

  void updateSelectedGoal(String goal) async {
    _log.info("Selecting goal $selectedGoal");
    setState(() {
      selectedGoal = goal;
    });
     await _completeOnboarding();
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
          title: Text('What is your primary goal?'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
                if (state is ButtonFailureState) {
              var snackbar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/goal.png",
                  width: 256,
                  height: 156,
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
                             widget.userCreationReq.goal = selectedGoal;
                        
                          // Handle navigation or next step
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>   DailyGoalPage(userCreationReq:widget.userCreationReq)));
                        },
                  isEnabled: selectedGoal == null,
                  text: 'NEXT',
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
      "👨‍👩‍👧‍👦 Chatting with family",
      "📚 Learning for Culture",
      "🌍 Just to discover",
      "💘 I want to impress someone",
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
