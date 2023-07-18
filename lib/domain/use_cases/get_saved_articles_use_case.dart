import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';

class GetSavedArticlesUseCase {
  final ArticleRepository _articleRepository;

  const GetSavedArticlesUseCase({required articleRepository}) : _articleRepository = articleRepository;

  Future<List<Article>> invoke() async {
    List<SavedArticle> savedArticles = await _articleRepository.getSavedArticles();
    return savedArticles.map((element) => Article(
        title: element.title,
        description: element.description,
        content: element.content,
        url: element.url,
        author: element.author,
        source: element.source,
        urlToImage: element.urlToImage
    )).toList();
  }
}