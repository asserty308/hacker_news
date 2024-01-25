import 'package:hacker_news/data/services/date_format.dart';

class StoryHistoryItem {
  StoryHistoryItem({
    required this.storyId, 
    required this.dateAdded,
  });

  factory StoryHistoryItem.fromJSON(Map<String, dynamic> json) => StoryHistoryItem(
    storyId: json['story_id'], 
    dateAdded: DateTime.parse(json['date_added']),
  );

  final int storyId;
  final DateTime dateAdded;

  Map<String, dynamic> toJSON() => {
    'story_id': storyId,
    'date_added': dateAdded.format('yyyy-MM-dd HH:mm'),
  };
}