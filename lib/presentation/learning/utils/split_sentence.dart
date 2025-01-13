class SplitSentence {
  final String firstPart;
  final String secondPart;

  SplitSentence({required this.firstPart, required this.secondPart});
}

SplitSentence splitSentenceAtBlank(String sentence) {
  try {
    final parts = sentence.split('___');
    if (parts.length != 2) {
      throw FormatException('Sentence must contain exactly one blank (___)');
    }
    
    // Capitalize first part if needed
    String firstPart = parts[0];
    // if (firstPart.isNotEmpty) {
    //   firstPart = firstPart[0].toUpperCase() + firstPart.substring(1);
    // }
    
    return SplitSentence(
      firstPart: firstPart,
      secondPart: parts[1].trim(),
    );
  } catch (e) {
    throw FormatException('Error splitting sentence: $e');
  }
}