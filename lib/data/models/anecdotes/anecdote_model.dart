
class Anecdote {
  String title;
  String subtitle;
  String content;
  String coverImage;
  String thumbnailImage;
  String category;
  Map<String, String> keywords;

  Anecdote({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.coverImage,
    required this.thumbnailImage,
    required this.category,
    required this.keywords,
  });

  // Getters
  String get gettitle => title;
  String get getsubtitle => subtitle;
  String get getcontent => content;
  String get getcoverImage => coverImage;
  String get getthumbnailImage => thumbnailImage;
  String get getcategory => category;

  // Setters
  set settitle(String value) => title = value;
  set setsubtitle(String value) => subtitle = value;
  set setcontent(String value) => content = value;
  set setcoverImage(String value) => coverImage = value;
  set setthumbnailImage(String value) => thumbnailImage = value;
  set setcategory(String value) => category = value;

  // Optional: Add factory method to create from Firestore
  factory Anecdote.fromFirestore(Map<String, dynamic> data) {
    return Anecdote(
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      content: data['content'] ?? '',
      coverImage: data['coverImage'] ?? 'assets/images/cover.png',
      thumbnailImage: data['thumbnailImage'] ?? 'assets/images/thumbnail.png',
      category: data['category'] ?? 'Stories',
      keywords: data['keywords'] ?? 'Stories',
    );
  }
}