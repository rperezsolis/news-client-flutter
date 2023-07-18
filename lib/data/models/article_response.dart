import 'dart:convert';
import 'package:news_client/data/models/article.dart';

ArticleResponse articleResponseFromJson(String str) => ArticleResponse.fromJson(json.decode(str));

String articleResponseToJson(ArticleResponse data) => json.encode(data.toJson());

class ArticleResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  const ArticleResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((articleJson) => Article.fromJson(articleJson))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((article) => article.toJson())),
  };
}