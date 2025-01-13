// lib/models/question_type.dart
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/learning/mock/word_building_mock_data.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/data/learning/models/question_state.dart';
import 'package:other_screens/presentation/congrats/pages/congrats_page.dart';
import 'package:other_screens/presentation/learning/widgets/feedback_overlay.dart';
import 'package:other_screens/presentation/learning/widgets/fill_blank_question_widget.dart';
import 'package:other_screens/presentation/learning/widgets/true_or_false.dart';
import 'package:other_screens/presentation/learning/widgets/validate_button.dart';
import 'package:other_screens/presentation/learning/widgets/word_question_widget.dart';
import 'package:other_screens/presentation/main/widgets/countdown_timer.dart';

enum QuestionType { fillBlank, trueOrFalse, multipleChoice, wordBuilding }

Logger _log = Logger("question_page.dart");

// lib/screens/question_page.dart
class QuestionPage extends StatefulWidget {
  final String levelImage;
  final String levelName;

  const QuestionPage({
    super.key,
    required this.levelImage,
    required this.levelName,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late QuestionState _state;
  bool? _showOverlay;
  bool? _isCorrect;

  @override
  void initState() {
    super.initState();
    // Initialize with sample questions (you'll fetch these from your data source)
    _state = QuestionState(
      currentIndex: 0,
      questions: [
        ...trueOrFalseQuestionList,
        WordBuildingQuestion(
          title: 'School',
          instruction: 'Build the word using the syllables',
          targetWord: 'graduation',
          availableSyllables: ['grad', 'u', 'a', 'tion'],
        ),
        ...wordBuildingQuestionList,
        FillInBlankQuestion(
          correctAnswer: "pluie",
          sentence:
              "aujourd'hui il fait un mauvait temps car il semble que la ___ tombera.",
          title: 'Climate',
          instruction: 'Fill in the blank',
        ),
        TrueOrFalseQuestion(
          word: "Appa'a",
          imageUrl: "assets/icons/mock-data/papa.png",
          correctAnswer: false,
        ),
      ],
      answers: [],
    );
  }

  void _handleAnswer(bool isCorrect) {
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
        question: question as WordBuildingQuestion,
        onAnswer: (answer) {
          _handleAnswer(answer.toLowerCase() ==
              (question as WordBuildingQuestion).targetWord.toLowerCase());
        },
      );
    }

    if (question is FillInBlankQuestion) {
      String userInput = ""; // Track the user's input

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
                    "Aujourd'hui il fait un mauvait temps car il semble que la ",
                secondPartOfSentence: "tombera.",
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
                              question.correctAnswer.toLowerCase(),
                        );
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
            child: Image.asset(
              widget.levelImage,
              width: mediaWidth(context) / 4.6,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(widget.levelName),
        actions: [
          CountdownTimer(),
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
