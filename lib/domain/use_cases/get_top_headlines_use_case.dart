import 'package:news_client/data/models/article_response.dart';
import 'package:news_client/data/models/result.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';

class GetTopHeadlinesUseCase {
  final ArticleRepository _articleRepository;

  const GetTopHeadlinesUseCase({required ArticleRepository articleRepository}) : _articleRepository = articleRepository;

  Future<Result<List<Article>>> invoke({required String countryCode}) async {
    Result<ArticleResponse> articleResult = await _articleRepository.getTopHeadlines(countryCode: countryCode);
    if (articleResult is SuccessResult) {
      List<Article> articles = (articleResult as SuccessResult<ArticleResponse>).data.articles
          .where((element) => element.description != null && element.content != null && element.url != null)
          .map((element) => Article(
          title: element.title,
          description: element.description!,
          content: element.content!,
          url: element.url!,
          author: element.author,
          source: element.source?.name,
      )).toList(growable: false);
      return SuccessResult(data: articles);
    } else {
      return ErrorResult(exception: (articleResult as ErrorResult).exception);
    }
  }
}
