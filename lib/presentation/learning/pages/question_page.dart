// lib/models/question_type.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/learning/mock/word_building_mock_data.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/data/learning/models/question_state.dart';
import 'package:other_screens/presentation/congrats/pages/congrats_page.dart';
import 'package:other_screens/presentation/learning/pages/times_up_page.dart';
import 'package:other_screens/presentation/learning/services/learning_stats_service.dart';
import 'package:other_screens/presentation/learning/utils/split_sentence.dart';
import 'package:other_screens/presentation/learning/widgets/feedback_overlay.dart';
import 'package:other_screens/presentation/learning/widgets/fill_blank_question_widget.dart';
import 'package:other_screens/presentation/learning/widgets/true_or_false.dart';
import 'package:other_screens/presentation/learning/widgets/validate_button.dart';
import 'package:other_screens/presentation/learning/widgets/word_question_widget.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:other_screens/presentation/main/widgets/countdown_timer.dart';
import 'package:other_screens/presentation/pricing/pages/pricing_page.dart';
import 'package:other_screens/presentation/pricing/widgets/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum QuestionType { fillBlank, trueOrFalse, multipleChoice, wordBuilding }

Logger _log = Logger("question_page.dart");

// lib/screens/question_page.dart
class QuestionPage extends StatefulWidget {
  final String levelImage;
  final String levelName;
  final String categoryName;

  const QuestionPage({
    super.key,
    required this.levelImage,
    required this.levelName,
    required this.categoryName,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late QuestionState _state;
  late LearningStatsService _statsService;
  bool? _showOverlay;
  bool? _isCorrect;

  @override
  void initState() {
    _initializeStats();
    // Filter questions by category
    List<Question> categoryQuestions = allQuestions
        .where((question) =>
            question.category?.toLowerCase() ==
            widget.categoryName.toLowerCase())
        .toList();

    // If no questions found for category, fallback to all questions
    if (categoryQuestions.isEmpty) {
      _log.warning('No questions found for category: ${widget.categoryName}');
      categoryQuestions = allQuestions;
    }

    // Shuffle the filtered questions
    categoryQuestions.shuffle(Random(42));

    super.initState();
    // Initialize with sample questions (will fetch these from data source)
    _state = QuestionState(
      currentIndex: 0,
      questions: categoryQuestions,
      answers: [],
    );
  }

  Future<void> _initializeStats() async {
    final prefs = await SharedPreferences.getInstance();
    _statsService = LearningStatsService(prefs);
  }

  void _handleAnswer(bool isCorrect) async {
    final currentQuestion = _state.questions[_state.currentIndex];

    // Track the word/phrase that was learned
    String wordLearned = '';
    if (currentQuestion is WordBuildingQuestion) {
      wordLearned = currentQuestion.targetWord;
    } else if (currentQuestion is FillInBlankQuestion) {
      wordLearned = currentQuestion.missingWord;
    } else if (currentQuestion is TrueOrFalseQuestion) {
      wordLearned = currentQuestion.word;
    }

    // Add to learned words if not empty
    if (isCorrect && wordLearned.isNotEmpty) {
      await _statsService.addLearnedWord(wordLearned);
    }

    setState(() {
      _showOverlay = true;
      _isCorrect = isCorrect;

      // Add answer to history
      List<bool> newAnswers = List.from(_state.answers)..add(isCorrect);

      // Update state
      _state = _state.copyWith(
        answers: newAnswers,
      );
    });

    // Wait for overlay animation then move to next question
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showOverlay = false;
          _isCorrect = null;

          // Move to next question if available
          if (_state.currentIndex < _state.questions.length - 1) {
            _state = _state.copyWith(
              currentIndex: _state.currentIndex + 1,
            );
          } else {
            // Handle completion - you can navigate to a results page here
            debugPrint('Quiz completed!');
            AppNavigator.push(
                context,
                CongratsPage(
                    stats: AchievementStats(
                  wordsLearned: 20,
                  completionPercentage: 100,
                )));
          }
        });
      }
    });
  }

  Widget _buildCurrentQuestion() {
    final question = _state.questions[_state.currentIndex];

    if (question is WordBuildingQuestion) {
      return WordBuildingQuestionWidget(
        imagePath: question.imagePath,
        question: question,
        icon: question.icon,
        onAnswer: (answer) {
          _handleAnswer(
              answer.toLowerCase() == (question).targetWord.toLowerCase());
        },
      );
    }

    if (question is FillInBlankQuestion) {
      String userInput = ""; // Track the user's input

      final controller = TextEditingController();
      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Look at the image below and pick one word to fill the gap in the sentence!',
                  style: AppTextStyles.h2
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
              ),
              SizedBox(
                height: mediaWidth(context) / 10,
              ),
              FillBlankQuestionWidget(
                question: question,
                onTextChanged: (value) {
                  setState(() {
                    userInput = value.trim(); // Update user input
                  });
                },
                firstPartOfSentence:
                    splitSentenceAtBlank(question.sentence).firstPart,
                secondPartOfSentence:
                    splitSentenceAtBlank(question.sentence).secondPart,
                controller: controller,
              ),
              Spacer(),
              ValidateButton(
                text: "VALIDATE",
                isEnabled:
                    userInput.isNotEmpty, // Enable if user input is not empty
                onPressed: userInput.isNotEmpty
                    ? () {
                        _handleAnswer(
                          userInput.toLowerCase() ==
                              question.missingWord.toLowerCase(),
                        );
                        controller.clear();
                      }
                    : null, // No action if input is empty
              ),
              SizedBox(
                height: mediaWidth(context) / 10,
              ),
            ],
          );
        },
      );
    }

    if (question is TrueOrFalseQuestion) {
      bool? selectedAnswer; // Track the user's selected answer

      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              SizedBox(
                height: mediaWidth(context) / 10,
              ),
              question.imageUrl != null
                  ? (TrueOrFalseWidget(
                      word: question.word,
                      wordImage: question.imageUrl!,
                    ))
                  : (TrueOrFalseWidget(
                      word: question.word,
                      iconImage: question.icon!,
                    )),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  trueButton(() {
                    setState(() {
                      selectedAnswer = true; // User selected True
                      _handleAnswer(selectedAnswer == question.correctAnswer);
                      // _log.info("Answer is true -----> ",
                      //     selectedAnswer == question.correctAnswer);
                    });
                  }),
                  falseButton(() {
                    setState(() {
                      selectedAnswer = false; // User selected False
                      _log.info(selectedAnswer);
                      _log.info("Answer is true -----> ");
                      _handleAnswer(selectedAnswer == question.correctAnswer);
                      _log.info(question.correctAnswer);
                    });
                  }),
                ],
              ),
              SizedBox(height: mediaWidth(context) / 10),
            ],
          );
        },
      );
    }
    _log.info(question.toString());
    return const Center(child: Text('Unsupported question type'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: scaffoldBgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: widget.levelName,
            child: GestureDetector(
              onTap: () {
                showDefaultDialog(
                  context: context,
                  title: "Leave Level?",
                  message:
                      "You will lose all your progress in this level if you continue.",
                  icon: Icons.warning_rounded,
                  backgroundColor: seedColor,
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, true), // Pop dialog with true
                      child: Text(
                        "I Agree",
                        style: TextStyle(
                          color: seedColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(
                          context, false), // Pop dialog with false
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ).then((confirmed) {
                  if (confirmed == true) {
                    Navigator.pop(context); // Pop the question page
                  }
                });
              },
              child: Image.asset(
                widget.levelImage,
                width: mediaWidth(context) / 4.6,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(widget.levelName),
        actions: [
          CountdownTimer(
            onTimeUp: () => showDefaultDialog(
                context: context,
                title: "Time's Up!",
                actions: [
                  TextButton(
                    onPressed: () {
                      AppNavigator.push(context, PremiumPage());
                    },
                    child: Text("Upgrade Now"),
                  ),
                  TextButton(
                    onPressed: () {
                      //TODO: When clicking here redirect to stats page first.
                      AppNavigator.pushReplacement(context, TimeUpStatsPage());
                    },
                    child: Text(
                      "Maybe Later",
                      style: TextStyle(color: seedColorPalette.shade700),
                    ),
                  ),
                ],
                message:
                    "Your free daily learning time has expired. Upgrade to premium to enjoy unlimited learning time!",
                backgroundColor: seedColor,
                content: Text(
                  "Your free daily learning time has expired. Upgrade to premium to enjoy unlimited learning time!",
                )),
          ),
          SizedBox(width: mediaWidth(context) / 16),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mediaWidth(context) / 16,
              vertical: 16.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _buildCurrentQuestion(),
            ),
          ),
          if (_showOverlay == true)
            FeedbackOverlay(
              isCorrect: _isCorrect!,
              onDismissed: () => setState(() => _showOverlay = false),
            ),
        ],
      ),
    );
  }
}
