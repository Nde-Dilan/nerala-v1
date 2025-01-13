import 'package:other_screens/data/models/main/fun_fact_model.dart';
import 'package:other_screens/presentation/learning/widgets/level_item.dart';

final List<LevelItem> learningItems = [
  LevelItem(
    levelName: "Family Seed",
    levelImage: "assets/icons/category/family.png",
    isPremium: false,
  ),
  LevelItem(
      levelName: "Roots of Love",
      isPremium: false,
      levelImage: "assets/icons/category/family.png"),
  LevelItem(
      levelName: "Home Harmony",
      isPremium: true,
      levelImage: "assets/icons/category/family.png"),
  LevelItem(
      levelName: "Legacy Builder",
      isPremium: true,
      levelImage: "assets/icons/category/family.png"),
];

final List<FunFact> funFacts = [
  FunFact(
    title: 'Anecdote',
    description: 'Fun facts about Cameroonian languages...',
    imagePath: 'assets/images/anecdotes.png',
  ),
  FunFact(
    title: 'Anecdote',
    description: 'Fun facts 1 about Cameroonian languages...',
    imagePath: 'assets/images/anecdotes.png',
  ),
  FunFact(
    title: 'Anecdote',
    description: 'Fun facts 2 about Cameroonian languages...',
    imagePath: 'assets/images/anecdotes.png',
  ),
  // Add more fun facts here
];
