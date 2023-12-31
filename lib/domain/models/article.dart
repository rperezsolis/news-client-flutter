import 'package:equatable/equatable.dart';

class Article extends Equatable{
  final String title;
  final String description;
  final String content;
  final String url;
  final String? author;
  final String? source;
  final String? urlToImage;

  const Article({required this.title, required this.description, required this.content,
    required this.url,this.author, this.source, this.urlToImage});

  @override
  List<Object?> get props => [title, description, content, url, author, source, urlToImage];
}