
// lib/models/question_state.dart
import 'package:other_screens/data/learning/models/question.dart';

class QuestionState {
  final int currentIndex;
  final List<Question> questions;
  final List<bool> answers;

  const QuestionState({
    required this.currentIndex,
    required this.questions,
    required this.answers,
  });

  QuestionState copyWith({
    int? currentIndex,
    List<Question>? questions,
    List<bool>? answers,
  }) {
    return QuestionState(
      currentIndex: currentIndex ?? this.currentIndex,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
    );
  }
}
