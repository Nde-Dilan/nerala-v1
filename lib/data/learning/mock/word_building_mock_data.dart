import 'package:flutter/material.dart';

import '../models/question.dart';

final List<TrueOrFalseQuestion> boolQuestions = [
  TrueOrFalseQuestion(
    word: "Mbáp",
    correctAnswer: true,
    icon: Icons.restaurant_menu,
  ),

];

var wordBuildingQuestionList = [
  WordBuildingQuestion(
    title: 'Family',
    instruction: 'Build the word using the syllables',
    targetWord: 'tshianu',
    availableSyllables: ['tshi', 'a', 'nu'],
    meaning: 'frère aîné',
  ),
  WordBuildingQuestion(
    title: 'Nature',
    instruction: 'Build the word using the syllables',
    targetWord: 'ahæœ',
    availableSyllables: ['ahæ', 'œ'],
    meaning: 'forêt',
  ),
  WordBuildingQuestion(
    title: 'Emotion',
    instruction: 'Build the word using the syllables',
    targetWord: 'a—∆mx«∆',
    availableSyllables: ['a—', '∆m', 'x«∆'],
    meaning: 'haine',
  ),
  WordBuildingQuestion(
    title: 'Profession',
    instruction: 'Build the word using the syllables',
    targetWord: 'ahŸrg—»o',
    availableSyllables: ['ahŸ', 'rg', '—»o'],
    meaning: 'évêque',
  ),
  WordBuildingQuestion(
    title: 'Animal',
    instruction: 'Build the word using the syllables',
    targetWord: 'auÿ¿',
    availableSyllables: ['au', 'ÿ¿'],
    meaning: 'chien',
  ),
  WordBuildingQuestion(
    title: 'Tool',
    instruction: 'Build the word using the syllables',
    targetWord: 'ahc—»œ',
    availableSyllables: ['ahc', '—»œ'],
    meaning: 'bidon',
  ),
  WordBuildingQuestion(
    title: 'Food',
    instruction: 'Build the word using the syllables',
    targetWord: 'ax«∆os«∆',
    availableSyllables: ['ax«', '∆o', 's«∆'],
    meaning: 'bègue',
  ),
  WordBuildingQuestion(
    title: 'Body Part',
    instruction: 'Build the word using the syllables',
    targetWord: 'aø»sr«æ',
    availableSyllables: ['aø', '»sr', '«æ'],
    meaning: 'œil',
  ),
  WordBuildingQuestion(
    title: 'Religion',
    instruction: 'Build the word using the syllables',
    targetWord: 'at¿œsd&s«',
    availableSyllables: ['at¿', 'œsd', '&s«'],
    meaning: 'très saint',
  ),
  WordBuildingQuestion(
    title: 'Household',
    instruction: 'Build the word using the syllables',
    targetWord: 'atœcx«¿',
    availableSyllables: ['atœ', 'cx«¿'],
    meaning: 'palais royal',
  )
];

final List<TrueOrFalseQuestion> trueOrFalseQuestionList = [
  // TrueOrFalseQuestion(
  //   word: "Mbáp",
  //   correctAnswer: true,
  //   icon: Icons.restaurant_menu,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Nkãp",
  //   correctAnswer: true,
  //   icon: Icons.attach_money,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Ndē",
  //   correctAnswer: true,
  //   icon: Icons.home,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Sãŋndē",
  //   correctAnswer: true,
  //   icon: Icons.cleaning_services,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Sóck",
  //   correctAnswer: true,
  //   icon: Icons.local_fire_department,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Ŋzẹ̄",
  //   correctAnswer: true,
  //   icon: Icons.checkroom,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Mǝvøọ",
  //   correctAnswer: true,
  //   icon: Icons.pets,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Fœ",
  //   correctAnswer: true,
  //   icon: Icons.person,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Mbwø",
  //   correctAnswer: true,
  //   icon: Icons.back_hand,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Mọ̀ck",
  //   correctAnswer: true,
  //   icon: Icons.local_fire_department,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Ṣhwǝ",
  //   correctAnswer: true,
  //   icon: Icons.water_drop,
  // ),

  // False answers (incorrect variations)
  // TrueOrFalseQuestion(
  //   word: "Mbápa",
  //   correctAnswer: false,
  //   icon: Icons.restaurant_menu,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Nkãpa",
  //   correctAnswer: false,
  //   icon: Icons.attach_money,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Ndēe",
  //   correctAnswer: false,
  //   icon: Icons.home,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Sãŋndēa",
  //   correctAnswer: false,
  //   icon: Icons.cleaning_services,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Sócka",
  //   correctAnswer: false,
  //   icon: Icons.local_fire_department,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Ŋzẹ̄e",
  //   correctAnswer: false,
  //   icon: Icons.checkroom,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Mǝvøọa",
  //   correctAnswer: false,
  //   icon: Icons.pets,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Fœe",
  //   correctAnswer: false,
  //   icon: Icons.person,
  // ),

  // TrueOrFalseQuestion(
  //   word: "Mbwøo",
  //   correctAnswer: false,
  //   icon: Icons.back_hand,
  // ),
];
