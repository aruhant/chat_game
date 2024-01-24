class Book {
  Book(
      {required this.title,
      required this.productid,
      required this.subtitle,
      required this.summary,
      required this.cover});
  final String productid, title, subtitle, summary, cover;
  factory Book.fromJson(Map<String, dynamic> jsonMap) {
    return Book(
        title: jsonMap['title'],
        subtitle: jsonMap['subtitle'],
        summary: jsonMap['summary'],
        productid: jsonMap['productid'],
        cover: jsonMap['cover'] ?? '');
  }
}
