// lib/widgets/word_building_question_widget.dart
import 'package:flutter/material.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/presentation/learning/widgets/draggable_letters_grid.dart';
import 'package:other_screens/presentation/learning/widgets/fill_blank_question_widget.dart';
import 'package:other_screens/presentation/learning/widgets/question_card.dart';

class WordBuildingQuestionWidget extends StatelessWidget {
  final WordBuildingQuestion question;
  final Function(String) onAnswer;

  const WordBuildingQuestionWidget({super.key, required this.question, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    return QuestionCard(
      
      question: question,
      child: Column(
        children: [
          DraggableLettersGrid(
            letters: question.availableLetters,
            onWordBuilt: onAnswer,
          ),
        ],
      ),
    );
  }
}
