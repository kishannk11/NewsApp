class Article {
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? author;
  final String? sourceName;

  Article({
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.author,
    this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
      author: json['author'],
      sourceName: json['source']?['name'],
    );
  }
}
