// lib/models/question.dart
import 'package:flutter/material.dart';
import 'package:other_screens/data/learning/models/choice.dart';

abstract class Question {
  final String title;
  final String instruction;

  Question({required this.title, required this.instruction});
}

class FillInBlankQuestion extends Question {
  final String sentence;
  final String correctAnswer;
  final String? imageUrl;
  final String? assetImage;

  FillInBlankQuestion({
    super.title = '',
    super.instruction = '',
    required this.sentence,
    required this.correctAnswer,
    this.imageUrl,
    this.assetImage,
  });
}

class MultipleChoiceQuestion extends Question {
  final List<Choice> choices;
  final String correctAnswer;
  final String? audioUrl;

  MultipleChoiceQuestion({
    required this.choices,
    required this.correctAnswer,
    this.audioUrl,
    super.title = '',
    super.instruction = '',
  });
}

class WordBuildingQuestion extends Question {
  final List<String> availableSyllables;
  final String targetWord;
  final String? meaning;

  WordBuildingQuestion({
    required super.title,
    required super.instruction,
    required this.availableSyllables,
    required this.targetWord,
    this.meaning,
  });
}

class TrueOrFalseQuestion extends Question {
  final String word;
  final String? imageUrl;
  final bool correctAnswer;
  final IconData? icon;

  TrueOrFalseQuestion({
    required this.word,
    this.imageUrl,
    required this.correctAnswer,
      this.icon,
  }) : super(title: '', instruction: '');
}
