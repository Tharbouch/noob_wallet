class NewsModel {
  final String title;
  final String link;
  final String description;
  final String images;

  NewsModel(
      {required this.title,
      required this.link,
      required this.description,
      required this.images});

  factory NewsModel.fromJson(dynamic json) {
    return NewsModel(
      title: json['title'] as String,
      link: json['link'] as String,
      description: json['description'] as String,
      images: json['tags'][0]['icon'] as String,
    );
  }

  static List<NewsModel> news(List news) {
    return news.map((items) {
      return NewsModel.fromJson(items);
    }).toList();
  }
}
