class Article {
  final int contentId;
  final String title;
  final String image;
  final String description;
  final String profile;
  final String writer;
  final String comment;
  final String time;
  final String dontKnow;

  const Article({
    required this.contentId,
    required this.title,
    required this.image,
    required this.description,
    required this.profile,
    required this.writer,
    required this.comment,
    required this.time,
    required this.dontKnow,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      contentId: json['contentId'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      profile: json['profile'],
      writer: json['writer'],
      comment: json['comment'],
      time: json['time'],
      dontKnow: json['dontknow'],
    );
  }
}
