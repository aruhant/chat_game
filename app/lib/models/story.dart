class Story {
  Story(
      {required this.title,
      required this.id,
      required this.subtitle,
      required this.summary,
      required this.cover});
  final String id, title, subtitle, summary, cover;
  // load from json
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
        id: json['productid'] ?? '',
        title: json['title'],
        subtitle: json['subtitle'],
        summary: json['summary'],
        cover: json['cover']);
  }
}
