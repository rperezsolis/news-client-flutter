import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';

class IsArticleSavedUseCase {
  final ArticleRepository _articleRepository;

  const IsArticleSavedUseCase({required ArticleRepository articleRepository})
      : _articleRepository = articleRepository;

  Future<bool> invoke({required Article article}) async {
    SavedArticle? savedArticle = await _articleRepository.getSavedArticleByUrl(url: article.url);
    return savedArticle != null;
  }
}