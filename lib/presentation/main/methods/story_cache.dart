import 'dart:convert';
import 'package:other_screens/data/models/anecdotes/anecdote_model.dart';
import 'package:other_screens/data/stories/stories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoriesCache {
  static const String _storiesCacheKey = 'cached_stories';
  
  static Future<void> cacheStories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storiesCacheKey, json.encode(storiesList..map((storyData) => Anecdote.fromJson(storyData))
    .toList()));
  }

  static Future<List<Anecdote>> getCachedStories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(_storiesCacheKey);
    
    if (cachedData != null) {
      final List<dynamic> decoded = json.decode(cachedData);
      return decoded
          .cast<Map<String, dynamic>>()
          .map((json) => Anecdote.fromFirestore(json))
          .toList();
    }
    
    // If no cache exists, cache the default stories and return them
    await cacheStories();
    return storiesList
        .map((storyData) => Anecdote.fromFirestore(storyData))
        .toList();
  }
}