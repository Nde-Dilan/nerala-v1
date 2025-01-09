import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/learning/models/choice.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/presentation/learning/widgets/audio_player.dart';
import 'package:other_screens/presentation/learning/widgets/fill_blank_question_widget.dart';
import 'package:other_screens/presentation/learning/widgets/multiple_choice_question_widget.dart';
import 'package:other_screens/presentation/learning/widgets/true_or_false.dart';
import 'package:other_screens/presentation/learning/widgets/validate_button.dart';
import 'package:other_screens/presentation/learning/widgets/word_building_question_widget.dart';
import 'package:other_screens/presentation/main/widgets/countdown_timer.dart';

Logger _log = Logger("question_page.dart");

class QuestionPage extends StatelessWidget {
  const QuestionPage(
      {super.key, required this.levelImage, required this.levelName});

  final String levelImage;
  final String levelName;

  @override
  Widget build(BuildContext context) {
    final List<Choice> choices = [
      const Choice(
        value: 'basic',
        label: 'Basic Plan',
        backgroundColor: Color(0xFF7ED957), // Green color from your theme
        imageUrl: 'assets/icons/mock-data/papa.png',
      ),
      const Choice(
        value: 'premium',
        label: 'Premium Package',
        backgroundColor: Color(0xFF93FF69), // Lighter green
        imageUrl: 'assets/icons/mock-data/papa.png',
      ),
      const Choice(
        value: 'family',
        label: 'Family Bundle',
        backgroundColor: Color(0xFF6BBF4B), // Darker green
        imageUrl: 'assets/icons/mock-data/papa.png',
      ),
      const Choice(
        value: 'enterprise',
        label: 'Enterprise Solution',
        backgroundColor: Color(0xFF5DAD3F), // Even darker green
        imageUrl: 'assets/icons/mock-data/papa.png',
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: levelName,
            child: Image.asset(
              levelImage,
              width: mediaWidth(context) / 4.6,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(levelName),
        actions: [
          CountdownTimer(),
          SizedBox(
            width: mediaWidth(context) / 16,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaWidth(context) / 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: mediaWidth(context) / 10,
              ),
              TrueOrFalseWidget(
                word: "Appa'a",
                wordImage: "assets/icons/mock-data/papa.png",
              ),
              SizedBox(
                height: mediaWidth(context) / 8,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  trueButton(() {}),
                  falseButton(() {}),
                ],
              ),

              // ValidateButton(
              //   text: "VALIDATE",
              //   isEnabled: true,
              //   onPressed: () {},
              // ),
              SizedBox(
                height: mediaWidth(context) / 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var multipleChoice = Column(
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Text(
        textAlign: TextAlign.center,
        'Listen carefully to the audio below and pick one image!',
        style: AppTextStyles.h2
            .copyWith(fontWeight: FontWeight.w500, fontSize: 17.0),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: AudioPlayer(
        url: 'assets/audio/background_music.mp3',
      ),
    ),
    SizedBox(
        // height: mediaWidth(context) / 8,
        ),
    // MultipleChoiceQuestionWidget(
    //   question: MultipleChoiceQuestion(
    //       choices: choices, correctAnswer: "family"),
    //   onAnswer: (String value) {

    //     debugPrint(value);
    //   },
    // ),
  ],
);

var draggableWidget = Column(
  children: [
    WordBuildingQuestionWidget(
      question: WordBuildingQuestion(
        availableLetters: ["Gra", "dua", "tion", "tion", "Cap"],
        title: 'Drag the word',
        instruction: '',
        correctWord: 'Graduationtion Cap',
      ),
      onAnswer: (String value) {},
    ),
  ],
);

var fillBlankWidget = Column(
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
        // height: mediaWidth(context) / 8,
        ),
    FillBlankQuestionWidget(
      question: FillInBlankQuestion(
        correctAnswer: "audio",
        sentence: 'Listen carefully to the  below and pick one image!',
      ),
      onAnswer: (String value) {
        _log.info(value);
      },
      firstPartOfSentence:
          'Aujourd’hui il fait un mauvait temps car il semble que la ',
      secondPartOfSentence: 'tombera.',
    ),
    SizedBox(
        // height: mediaWidth(context) / 8,
        ),
  ],
);
