
// lib/widgets/multiple_choice_question_widget.dart
import 'package:flutter/material.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/presentation/learning/widgets/choice_card.dart';
import 'package:other_screens/presentation/learning/widgets/fill_blank_question_widget.dart';

class MultipleChoiceQuestionWidget extends StatelessWidget {
  final MultipleChoiceQuestion question;
  final Function(String) onAnswer;

  const MultipleChoiceQuestionWidget({super.key, required this.question, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
 
    return QuestionCard(
      question: question,
      child: Column(
        children: [
          if (question.audioUrl != null)
            // AudioPlayer(url: question.audioUrl!),
          GridView.builder(
            itemCount: question.choices.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              return ChoiceCard(
                choice: question.choices[index],
                onTap: () => onAnswer(question.choices[index].value),
              );
            },
          ),
        ],
      ),
    );
  }
}