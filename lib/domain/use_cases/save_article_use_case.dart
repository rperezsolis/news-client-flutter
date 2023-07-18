import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';

class SaveArticleUseCase {
  final ArticleRepository _articleRepository;

  const SaveArticleUseCase({required articleRepository}) : _articleRepository = articleRepository;

  Future<int> invoke({required Article article}) async {
    return await _articleRepository.saveArticle(title: article.title, description: article.description,
        content: article.content, url: article.url, author: article.author, source: article.source,
        urlToImage: article.urlToImage);
  }
}