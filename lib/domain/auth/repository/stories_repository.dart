import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:other_screens/data/models/anecdotes/anecdote_model.dart';

abstract class StoriesRepository {
  Future<List<Anecdote>> getStories();
}

class StoriesRepositoryImpl extends StoriesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Anecdote>> getStories() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('stories')
          .orderBy('createdAt', descending: true)
          .get();

      List<Anecdote> stories = [];

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        // Fetch keywords subcollection for each story
        final keywordsSnapshot =
            await doc.reference.collection('keywords').get();

        // Convert keywords documents to a Map
        Map<String, String> keywords = {};
        for (var keywordDoc in keywordsSnapshot.docs) {
          final keywordData = keywordDoc.data();
          keywords[keywordData['english']] = keywordData['french'];
        }

        stories.add(
          Anecdote(
            title: data['title'] ?? '',
            subtitle: data['title'] ?? '', // Using title as subtitle
            content: data['body'] ?? '',
            coverImage: data['imageUrl'] ?? 'assets/images/cover.png',
            thumbnailImage:
                data['thumbnailUrl'] ?? 'assets/images/thumbnail.png',
            category: 'Stories',
            keywords: keywords,
          ),
        );
      }

      return stories;
    } catch (e) {
      print('Error fetching stories: $e');
      return [];
    }
  }
}
