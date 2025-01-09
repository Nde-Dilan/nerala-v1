// lib/widgets/question_card.dart
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/presentation/learning/widgets/question_card.dart';

Logger _log = Logger("fill_blank_question_widget.dart");

// lib/widgets/
class FillBlankQuestionWidget extends StatelessWidget {
  final FillInBlankQuestion question;
  final String firstPartOfSentence;
  final String secondPartOfSentence;
  final Function(String) onAnswer;

  const FillBlankQuestionWidget(
      {super.key,
      required this.question,
      required this.onAnswer,
      required this.firstPartOfSentence,
      required this.secondPartOfSentence});

  @override
  Widget build(BuildContext context) {
    return QuestionCard(
      question: question,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (question.imageUrl != null)
              ? Image(image: NetworkImage(question.imageUrl!))
              : Image.asset("assets/icons/mock-data/pluie.png"),
          SizedBox(
            height: mediaWidth(context) / 8,
          ),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: firstPartOfSentence,
                style: DefaultTextStyle.of(context).style,
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: mediaWidth(context) / 6,
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: onAnswer,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: -5),
                          hintMaxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: secondPartOfSentence,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
