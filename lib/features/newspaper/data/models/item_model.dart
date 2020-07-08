class ItemModel {
  ItemModel({
    this.deleted, 
    this.type, 
    this.by, 
    this.time, 
    this.text, 
    this.dead, 
    this.parent,
    this.poll, 
    this.kids, 
    this.url, 
    this.score, 
    this.title, 
    this.parts, 
    this.descendants
  });

  /// true if the item is deleted.
  final bool deleted;

  /// The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  final String type;

  /// The username of the item's author.
  final String by;

  /// Creation date of the item, in Unix Time.
  final int time;

  /// The comment, story or poll text. HTML.
  final String text;

  /// true if the item is dead.
  final bool dead;

  /// The comment's parent: either another comment or the relevant story.
  final int parent;

  /// The pollopt's associated poll.
  final int poll;

  /// The ids of the item's comments, in ranked display order.
  final List<int> kids;

  /// The URL of the story.
  final String url;

  /// The story's score, or the votes for a pollopt.
  final int score;

  ///The title of the story, poll or job. HTML.
  final String title;

  /// A list of related pollopts, in display order.
  final List<int> parts;

  /// In the case of stories or polls, the total comment count.
  final int descendants;

  static ItemModel fromJSON(Map<String, dynamic> json) => ItemModel(
    deleted: json['deleted'],
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
  );
}