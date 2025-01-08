import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/presentation/learning/widgets/audio_player.dart';
import 'package:other_screens/presentation/learning/widgets/click_to_listen.dart';
import 'package:other_screens/presentation/learning/widgets/multiple_choice_question_widget.dart';
import 'package:other_screens/presentation/learning/widgets/question_header.dart';
import 'package:other_screens/presentation/learning/widgets/validate_button.dart';
import 'package:other_screens/presentation/main/widgets/countdown_timer.dart';
import 'package:other_screens/presentation/pages/landing_page.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage(
      {super.key, required this.levelImage, required this.levelName});

  final String levelImage;
  final String levelName;

  @override
  Widget build(BuildContext context) {
    List<Choice> choices = [];
    return Scaffold(
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
        child: Column(
          children: [
            SizedBox(
              height: mediaWidth(context) / 8,
            ),
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
            // QuestionHeader(
            //   title: 'Animals',
            //   instruction:
            //       "",
            //   leading: Icon(Icons.pets, color: Colors.blue),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: AudioPlayer(
                url: 'assets/audio/background_music.mp3',
              ),
            ),
            SizedBox(
              height: mediaWidth(context) / 8,
            ),
            MultipleChoiceQuestionWidget(
              question: MultipleChoiceQuestion(
                  title: "title",
                  instruction: "instruction",
                  choices: choices,
                  correctAnswer: "correctAnswer"),
              onAnswer: (String) {},
            ),
            SizedBox(
              height: mediaWidth(context) / 8,
            ),
            ValidateButton(text: "VALIDATE")
          ],
        ),
      ),
    );
  }
}
