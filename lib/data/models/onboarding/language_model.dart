
// Data model for language
class Language {
  final String name;
  final String region;
  final String flagEmoji;
  final String description;

  const Language({
    required this.name,
    required this.region,
    required this.description,
    this.flagEmoji = '🌍', // Default flag emoji
  });
}
