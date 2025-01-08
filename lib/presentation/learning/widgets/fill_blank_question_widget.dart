// lib/widgets/question_card.dart
import 'package:flutter/material.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/presentation/learning/widgets/question_header.dart';
import 'package:other_screens/presentation/onboarding/pages/language_selection_page.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Widget child;
  final VoidCallback? onNext;

  const QuestionCard({
    super.key,
    required this.question,
    required this.child,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          QuestionHeader(
            title: question.title,
            instruction: question.instruction,
          ),
          child,
          if (onNext != null)
            NextButton(onPressed: onNext!, isEnabled: true,),
        ],
      ),
    );
  }
}

// lib/widgets/fill_blank_question_widget.dart
class FillBlankQuestionWidget extends StatelessWidget {
  final FillInBlankQuestion question;
  final Function(String) onAnswer;

  const FillBlankQuestionWidget({super.key, required this.question, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    return QuestionCard(
      question: question,
      child: Column(
        children: [
          if (question.imageUrl != null)
            Image(image:NetworkImage( question.imageUrl!)),
          TextField(
            onChanged: onAnswer,
            decoration: InputDecoration(
              hintText: 'Enter your answer',
            ),
          ),
        ],
      ),
    );
  }
}


