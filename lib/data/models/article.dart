import 'package:news_client/data/models/source.dart';

class Article {
  final String title;
  final String? description;
  final String? content;
  final Source? source;
  final String? author;
  final String? url;

  const Article({
    required this.title,
    this.description,
    this.content,
    this.author,
    this.source,
    this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json["title"],
    description: json["description"],
    content: json["content"],
    source: Source.fromJson(json["source"]),
    author: json["author"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "content": content,
    "source": source?.toJson(),
    "author": author,
    "url": url,
  };
}