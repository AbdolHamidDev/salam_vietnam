class CulturalArticle {
  final String id;
  final String title;
  final String summary;
  final String bodyContent;
  final String category;
  final String imageUrl;
  final String authorName;
  final String sourceAttribution;
  final DateTime publishedAt;

  const CulturalArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.bodyContent,
    required this.category,
    required this.imageUrl,
    required this.authorName,
    required this.sourceAttribution,
    required this.publishedAt,
  });
}
