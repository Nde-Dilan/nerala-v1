// lib/models/question.dart
import 'package:flutter/material.dart';
import 'package:other_screens/data/learning/models/choice.dart';

abstract class Question {
  final String category;
  final String instruction;

  Question({required this.category, required this.instruction});
}

class FillInBlankQuestion extends Question {
  final String sentence;
  final String missingWord;
  final String? imageUrl;
  final String? assetImage;

  FillInBlankQuestion({
    required super.category,
    super.instruction = 'Look at the image below and pick one word to fill the gap in the sentence!',
    required this.sentence,
    required this.missingWord,
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
    required super.category,
    super.instruction = '',
  });
}

class WordBuildingQuestion extends Question {
  final List<String> availableSyllables;
  final String targetWord;
  ///Correspond to the translate version of [targetWord]
  final String? meaning;
  final String? imagePath;
  final IconData? icon;

  WordBuildingQuestion({
    this.imagePath, this.icon, 
    super.instruction ="Use the syllables to form a correct word!",
    required super.category,
    required this.availableSyllables,
    required this.targetWord,
    this.meaning,
  });
}

class TrueOrFalseQuestion extends Question {
  final String word;
  final String targetWord;
  final String? imageUrl;
  final bool correctAnswer;
  final IconData? icon;

  TrueOrFalseQuestion({
    required this.targetWord,
    required super.category,
    required this.word,
    this.imageUrl,
    required this.correctAnswer,
    this.icon,
  }):super(instruction: "Is it True or False ?") ;
}
