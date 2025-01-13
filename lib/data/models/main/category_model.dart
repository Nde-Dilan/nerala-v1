// Models
class Category {
  final String title;
  final String imagePath;
  final String imagePath2;
  final int numberOfLevels;
  final String route;
  final String quoteText;

  const Category({
    required this.quoteText,
    required this.title,
    required this.imagePath,
    required this.imagePath2,
    required this.numberOfLevels,
    required this.route,
  });
}
