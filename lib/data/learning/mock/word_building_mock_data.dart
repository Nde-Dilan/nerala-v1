import '../models/question.dart';

List<Question> allQuestions = [
  ...natureQuestions,
  ...animalQuestions,
  ...schoolQuestions,
  ...sportQuestions,
  ...climateQuestions,
  ...famillyQuestions,
];

final List<Question> natureQuestions = [
  // True or False Questions
  TrueOrFalseQuestion(
    word: "farm",
    targetWord: "farm",
    category: "Nature",
    correctAnswer: true,
    imageUrl: "assets/images/category/nature/farm.png",
  ),
  TrueOrFalseQuestion(
    word: "forest",
    targetWord: "jungle",
    category: "Nature",
    correctAnswer: true,
    imageUrl: "assets/images/category/nature/forest.png",
  ),
  TrueOrFalseQuestion(
    word: "grass",
    targetWord: "grass",
    category: "Nature",
    correctAnswer: true,
    imageUrl: "assets/images/category/nature/grass.png",
  ),
  TrueOrFalseQuestion(
    word: "leaf",
    targetWord: "flower",
    category: "Nature",
    correctAnswer: false,
    imageUrl: "assets/images/category/nature/leaf.png",
  ),
  TrueOrFalseQuestion(
    word: "wind",
    targetWord: "breeze",
    category: "Nature",
    correctAnswer: true,
    imageUrl: "assets/images/category/nature/wind.png",
  ),

  // Word Building Questions
  WordBuildingQuestion(
    category: 'Nature',
    targetWord: 'farm',
    availableSyllables: ['far', 'm'],
    imagePath: "assets/images/category/nature/farm.png",
    meaning: 'A place where crops and animals are raised.',
  ),
  WordBuildingQuestion(
    category: 'Nature',
    targetWord: 'forest',
    availableSyllables: ['for', 'est'],
    imagePath: "assets/images/category/nature/forest.png",
    meaning: 'A large area covered with trees and plants.',
  ),
  WordBuildingQuestion(
    category: 'Nature',
    targetWord: 'grass',
    availableSyllables: ['gr', 'ass'],
    imagePath: "assets/images/category/nature/grass.png",
    meaning:
        'A plant with narrow green leaves that grows in fields and gardens.',
  ),
  WordBuildingQuestion(
    category: 'Nature',
    targetWord: 'leaf',
    availableSyllables: ['le', 'af'],
    imagePath: "assets/images/category/nature/leaf.png",
    meaning: 'A flat, green part of a plant that absorbs sunlight.',
  ),
  WordBuildingQuestion(
    category: 'Nature',
    targetWord: 'wind',
    availableSyllables: ['wi', 'nd'],
    imagePath: "assets/images/category/nature/wind.png",
    meaning: 'The natural movement of air in the environment.',
  ),

  // Fill in the Blank Questions
  FillInBlankQuestion(
    category: 'Nature',
    missingWord: 'farm',
    sentence: 'The cows live on a big ___.',
    assetImage: 'assets/images/category/nature/farm.png',
  ),
  FillInBlankQuestion(
    category: 'Nature',
    missingWord: 'forest',
    sentence: 'Many wild animals live in the ___.',
    assetImage: 'assets/images/category/nature/forest.png',
  ),
  FillInBlankQuestion(
    category: 'Nature',
    missingWord: 'grass',
    sentence: 'The horse is eating fresh ___.',
    assetImage: 'assets/images/category/nature/grass.png',
  ),
  FillInBlankQuestion(
    category: 'Nature',
    missingWord: 'leaf',
    sentence: 'In autumn, each ___ changes color before falling.',
    assetImage: 'assets/images/category/nature/leaf.png',
  ),
  FillInBlankQuestion(
    category: 'Nature',
    missingWord: 'wind',
    sentence: 'The ___ is blowing strongly today.',
    assetImage: 'assets/images/category/nature/wind.png',
  ),
];

final List<Question> animalQuestions = [
  TrueOrFalseQuestion(
      word: "bird",
      targetWord: "bird",
      category: "Animal",
      correctAnswer: true,
      imageUrl: "assets/images/category/animals/bird.png"),
  TrueOrFalseQuestion(
      word: "dog",
      targetWord: "dog",
      category: "Animal",
      correctAnswer: true,
      imageUrl: "assets/images/category/animals/dog.png"),
  TrueOrFalseQuestion(
      word: "cat",
      targetWord: "cat",
      category: "Animal",
      correctAnswer: true,
      imageUrl: "assets/images/category/animals/cat.png"),
  TrueOrFalseQuestion(
      word: "fish",
      targetWord: "fish",
      category: "Animal",
      correctAnswer: true,
      imageUrl: "assets/images/category/animals/fish.png"),
  TrueOrFalseQuestion(
      word: "rat",
      targetWord: "rat",
      category: "Animal",
      correctAnswer: true,
      imageUrl: "assets/images/category/animals/rat.png"),
  WordBuildingQuestion(
      category: 'Animal',
      targetWord: 'bird',
      availableSyllables: ['bir', 'rd', 'd'],
      meaning: 'bird',
      imagePath: "assets/images/category/animals/bird.png"),
  WordBuildingQuestion(
    category: 'Animal',
    targetWord: 'cat',
    availableSyllables: ['c', 'o', 'a', 't'],
    imagePath: "assets/images/category/animals/cat.png",
    meaning: 'cat',
  ),
  WordBuildingQuestion(
    category: 'Animal',
    targetWord: 'dog',
    availableSyllables: ['g', 'd', 'o'],
    imagePath: "assets/images/category/animals/dog.png",
    meaning: 'dog',
  ),
  WordBuildingQuestion(
    category: 'Animal',
    targetWord: 'fish',
    availableSyllables: ['fi', '5', 'sh', 'o'],
    imagePath: "assets/images/category/animals/fish.png",
    meaning: 'fish',
  ),
  WordBuildingQuestion(
    category: 'Animal',
    targetWord: 'rat',
    availableSyllables: ['rat', 'œ'],
    imagePath: "assets/images/category/animals/rat.png",
    meaning: 'rat',
  ),
  FillInBlankQuestion(
    category: 'Animal',
    missingWord: 'bird',
    sentence: 'The ___ is flying high in the sky.',
    assetImage: 'assets/images/category/animals/bird.png',
  ),
  FillInBlankQuestion(
    category: 'Animal',
    missingWord: 'cat',
    sentence: 'The ___ loves to chase mice.',
    assetImage: 'assets/images/category/animals/cat.png',
  ),
  FillInBlankQuestion(
    category: 'Animal',
    missingWord: 'dog',
    sentence: 'The ___ is man\'s best friend.',
    assetImage: 'assets/images/category/animals/dog.png',
  ),
  FillInBlankQuestion(
    category: 'Animal',
    missingWord: 'fish',
    sentence: 'The ___ swims gracefully in the water.',
    assetImage: 'assets/images/category/animals/fish.png',
  ),
  FillInBlankQuestion(
    category: 'Animal',
    missingWord: 'rat',
    sentence: 'A ___ scurried across the kitchen floor.',
    assetImage: 'assets/images/category/animals/rat.png',
  ),
];
final List<Question> climateQuestions = [
  FillInBlankQuestion(
    category: 'Climate',
    missingWord: 'rain',
    sentence: 'Today the weather is bad because it seems that ___ will fall.',
    assetImage: 'assets/images/category/climate/rain.png',
  ),
  FillInBlankQuestion(
    category: 'Climate',
    missingWord: 'sun',
    sentence: 'The ___ is shining brightly in the sky.',
    assetImage: 'assets/images/category/climate/sun.png',
  ),
];
final List<Question> famillyQuestions = [
  TrueOrFalseQuestion(
      word: "brother",
      targetWord: "brother",
      category: "Family",
      correctAnswer: true,
      imageUrl: "assets/images/category/family/brother.png"),
  TrueOrFalseQuestion(
      word: "children",
      targetWord: "children",
      category: "Family",
      correctAnswer: true,
      imageUrl: "assets/images/category/family/children.png"),
  TrueOrFalseQuestion(
      word: "mother",
      targetWord: "mother",
      category: "Family",
      correctAnswer: true,
      imageUrl: "assets/images/category/family/mother.png"),
  TrueOrFalseQuestion(
      word: "siblings",
      targetWord: "siblings",
      category: "Family",
      correctAnswer: true,
      imageUrl: "assets/images/category/family/siblings-1.png"),
  TrueOrFalseQuestion(
      word: "sister",
      targetWord: "sister",
      category: "Family",
      correctAnswer: true,
      imageUrl: "assets/images/category/family/sister.png"),
  WordBuildingQuestion(
      category: 'Family',
      targetWord: 'brother',
      availableSyllables: ['ro', 'bro', 't', 'her'],
      meaning: 'brother',
      imagePath: "assets/images/category/family/brother.png"),
  WordBuildingQuestion(
    category: 'Family',
    targetWord: 'children',
    availableSyllables: ['chi', 'ld', 'ren'],
    imagePath: "assets/images/category/family/children.png",
    meaning: 'children',
  ),
  WordBuildingQuestion(
    category: 'Family',
    targetWord: 'mother',
    availableSyllables: ['er', 'th', 'mo', 'ta'],
    imagePath: "assets/images/category/family/mother.png",
    meaning: 'mother',
  ),
  WordBuildingQuestion(
    category: 'Family',
    targetWord: 'siblings',
    availableSyllables: ['ings', 'bli', 'si'],
    imagePath: "assets/images/category/family/siblings.png",
    meaning: 'siblings',
  ),
  WordBuildingQuestion(
    category: 'Family',
    targetWord: 'sister',
    availableSyllables: ['bro', 'sis', 'ther', 'ter'],
    imagePath: "assets/images/category/family/sister.png",
    meaning: 'sister',
  ),
  FillInBlankQuestion(
    category: 'Family',
    missingWord: 'brother',
    sentence: 'My ___ is always there to help me.',
    assetImage: 'assets/images/category/family/brother.png',
  ),
  FillInBlankQuestion(
    category: 'Family',
    missingWord: 'children',
    sentence: 'The ___ are playing in the park.',
    assetImage: 'assets/images/category/family/children.png',
  ),
  FillInBlankQuestion(
    category: 'Family',
    missingWord: 'mother',
    sentence: 'My ___ makes the best meals.',
    assetImage: 'assets/images/category/family/mother.png',
  ),
  FillInBlankQuestion(
    category: 'Family',
    missingWord: 'siblings',
    sentence: 'I love spending time with my ___.',
    assetImage: 'assets/images/category/family/siblings.png',
  ),
  FillInBlankQuestion(
    category: 'Family',
    missingWord: 'sister-1',
    sentence: 'My ___ is my closest friend.',
    assetImage: 'assets/images/category/family/sister-1.png',
  ),
  FillInBlankQuestion(
    category: 'Family',
    missingWord: 'sister',
    sentence: 'My ___ is someone I can always rely on.',
    assetImage: 'assets/images/category/family/sister.png',
  ),
];
final List<dynamic> schoolQuestions = [
  // True or False Questions
  TrueOrFalseQuestion(
    word: "blackboard",
    targetWord: "chalkboard",
    category: "School",
    correctAnswer: true,
    imageUrl: "assets/images/category/school/blackboard.png",
  ),
  TrueOrFalseQuestion(
    word: "textbook",
    targetWord: "notebook",
    category: "School",
    correctAnswer: false,
    imageUrl: "assets/images/category/school/book.png",
  ),
  TrueOrFalseQuestion(
    word: "book",
    targetWord: "notebook",
    category: "School",
    correctAnswer: true,
    imageUrl: "assets/images/category/school/book.png",
  ),
  TrueOrFalseQuestion(
    word: "Flag",
    targetWord: "flag",
    category: "School",
    correctAnswer: true,
    imageUrl: "assets/images/category/school/flag-cm.png",
  ),
  TrueOrFalseQuestion(
    word: "pencil",
    targetWord: "pen",
    category: "School",
    correctAnswer: true,
    imageUrl: "assets/images/category/school/pencil.png",
  ),
  TrueOrFalseQuestion(
    word: "pen",
    targetWord: "pen",
    category: "School",
    correctAnswer: false,
    imageUrl: "assets/images/category/school/pencil.png",
  ),
  TrueOrFalseQuestion(
    word: "school",
    targetWord: "university",
    category: "School",
    correctAnswer: true,
    imageUrl: "assets/images/category/school/school.png",
  ),
  TrueOrFalseQuestion(
    word: "teacher",
    targetWord: "coach",
    category: "School",
    correctAnswer: true,
    imageUrl: "assets/images/category/school/teacher.png",
  ),

  // Word Building Questions
  WordBuildingQuestion(
    category: 'School',
    targetWord: 'blackboard',
    availableSyllables: ['black', 'board'],
    imagePath: "assets/images/category/school/blackboard.png",
    meaning: 'A surface used by teachers to write lessons.',
  ),
  WordBuildingQuestion(
    category: 'School',
    targetWord: 'book',
    availableSyllables: ['bo', 'ok'],
    imagePath: "assets/images/category/school/book.png",
    meaning: 'A collection of pages used for studying.',
  ),
  WordBuildingQuestion(
    category: 'School',
    targetWord: 'flag',
    availableSyllables: ['flag'],
    imagePath: "assets/images/category/school/flag-cm.png",
    meaning: 'A symbol representing a country, often found in schools.',
  ),
  WordBuildingQuestion(
    category: 'School',
    targetWord: 'pencil',
    availableSyllables: ['pen', 'cil'],
    imagePath: "assets/images/category/school/pencil.png",
    meaning: 'A writing tool used by students.',
  ),
  WordBuildingQuestion(
    category: 'School',
    targetWord: 'school',
    availableSyllables: ['school'],
    imagePath: "assets/images/category/school/school.png",
    meaning: 'A place where students learn.',
  ),
  WordBuildingQuestion(
    category: 'School',
    targetWord: 'teacher',
    availableSyllables: ['teach', 'er'],
    imagePath: "assets/images/category/school/teacher.png",
    meaning: 'A person who helps students learn.',
  ),

  // Fill in the Blank Questions
  FillInBlankQuestion(
    category: 'School',
    missingWord: 'blackboard',
    sentence: 'The teacher wrote the lesson on the ___.',
    assetImage: 'assets/images/category/school/blackboard.png',
  ),
  FillInBlankQuestion(
    category: 'School',
    missingWord: 'book',
    sentence: 'I borrowed a ___ from the library.',
    assetImage: 'assets/images/category/school/book.png',
  ),
  FillInBlankQuestion(
    category: 'School',
    missingWord: 'flag',
    sentence: 'Every morning, we raise the ___.',
    assetImage: 'assets/images/category/school/flag-cm.png',
  ),
  FillInBlankQuestion(
    category: 'School',
    missingWord: 'pencil',
    sentence: 'She sharpened her ___ before the test.',
    assetImage: 'assets/images/category/school/pencil.png',
  ),
  FillInBlankQuestion(
    category: 'School',
    missingWord: 'school',
    sentence: 'Students go to ___ to learn new things.',
    assetImage: 'assets/images/category/school/school.png',
  ),
  FillInBlankQuestion(
    category: 'School',
    missingWord: 'teacher',
    sentence: 'My ___ always helps me understand math.',
    assetImage: 'assets/images/category/school/teacher.png',
  ),
];
final List<Question> entertainmentQuestions = [];
final List<Question> sportQuestions = [];

final List<TrueOrFalseQuestion> commentedTrueOrFalseQuestionList = [
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
