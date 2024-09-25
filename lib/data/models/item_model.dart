import 'package:flutter/material.dart';
import 'package:hacker_news/l10n/l10n.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.type, 
    required this.by, 
    required this.time, 
    required this.url, 
    required this.score, 
    required this.title, 
    this.parts, 
    this.descendants,
    this.deleted, 
    this.text, 
    this.dead, 
    this.parent,
    this.poll, 
    this.kids, 
  });

  factory ItemModel.fromJSON(Map<String, dynamic> json) => ItemModel(
    id: json['id'],
    type: json['type'],
    by: json['by'],
    time: json['time'],
    text: json['text'],
    dead: json['dead'],
    parent: json['parent'],
    poll: json['poll'],
    kids: json['kids'],
    url: json['url'],
    score: json['score'],
    title: json['title'],
    parts: json['parts'],
    descendants: json['descendants'],
    deleted: json['deleted'],
  );

  /// The item's unique id.
  final int id;

  /// true if the item is deleted.
  final bool? deleted;

  /// The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  final String type;

  /// The username of the item's author.
  final String by;

  /// Creation date of the item, in Unix Time.
  final int time;

  /// The comment, story or poll text. HTML.
  final String? text;

  /// true if the item is dead.
  final bool? dead;

  /// The comment's parent: either another comment or the relevant story.
  final int? parent;

  /// The pollopt's associated poll.
  final int? poll;

  /// The ids of the item's comments, in ranked display order.
  final List<dynamic>? kids;

  /// The URL of the story.
  final String? url;

  /// The story's score, or the votes for a pollopt.
  final int score;

  ///The title of the story, poll or job. HTML.
  final String title;

  /// A list of related pollopts, in display order.
  final List<dynamic>? parts;

  /// In the case of stories or polls, the total comment count.
  final int? descendants;

  /// Creates a JSON Object of the [ItemModel].
  Map<String, dynamic> toJSON() => {
    'id': id,
    'deleted': deleted,
    'type': type,
    'by': by,
    'time': time,
    'text': text,
    'dead': dead,
    'parent': parent,
    'poll': poll,
    'kids': kids,
    'url': url,
    'score': score,
    'title': title,
    'parts': parts,
    'descendants': descendants,
  };

  /// Converts the unix [time] to a [DateTime] object.
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(time * 1000);

  /// Representes the [dateTime] object as a human readable difference until now.
  /// 
  /// Example: "1 hour ago" or "2 days ago"
  String formattedDifference(BuildContext context) {
    final diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) {
      return context.l10n.nSecondsAgo(diff.inSeconds);
    } else if (diff.inMinutes < 60) {
      return context.l10n.nMinutesAgo(diff.inMinutes);
    } else if (diff.inHours < 24) {
      return context.l10n.nHoursAgo(diff.inHours);
    }
    
    return context.l10n.nDaysAgo(diff.inDays);
  }

  String get urlAuthority => Uri.tryParse(url ?? '')?.authority ?? '';

  Uri get realUrl {
    if (url?.isEmpty ?? true) {
      return Uri.https('news.ycombinator.com', '/item', {'id':'$id'});
    }

    return Uri.parse(url!);
  }
}
