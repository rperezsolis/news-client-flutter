import 'package:news_client/data/repositories/article_repository.dart';

class UnSaveArticleUseCase {
  final ArticleRepository _articleRepository;

  const UnSaveArticleUseCase({required articleRepository}) : _articleRepository = articleRepository;

  Future<int> invoke({required String url}) async {
    return await _articleRepository.unSaveArticle(url: url);
  }
}