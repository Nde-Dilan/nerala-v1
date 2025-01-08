// lib/models/question.dart
import 'package:flutter/material.dart';

abstract class Question {
  final String title;
  final String instruction;

  Question({required this.title, required this.instruction});
}

class FillInBlankQuestion extends Question {
  final String sentence;
  final String correctAnswer;
  final String? imageUrl;

  FillInBlankQuestion({
    required super.title,
    required super.instruction,
    required this.sentence,
    required this.correctAnswer,
    this.imageUrl,
  });
}

class MultipleChoiceQuestion extends Question {
  final List<Choice> choices;
  final String correctAnswer;
  final String? audioUrl;

  MultipleChoiceQuestion({
    required super.title,
    required super.instruction,
    required this.choices,
    required this.correctAnswer,
    this.audioUrl,
  });
}

// / lib/models/choice.dart
class Choice {
  final String value;
  final String label;
  final String? imageUrl;
  final Color? backgroundColor;

  const Choice({
    required this.value,
    required this.label,
    this.imageUrl,
    this.backgroundColor,
  });
}

class WordBuildingQuestion extends Question {
  final List<String> availableLetters;
  final String correctWord;

  WordBuildingQuestion({
    required super.title,
    required super.instruction,
    required this.availableLetters,
    required this.correctWord,
  });
}
