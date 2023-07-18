import 'package:flutter/foundation.dart';
import 'package:news_client/data/models/result.dart';
import 'package:news_client/domain/models/article.dart';
import 'package:news_client/domain/use_cases/get_top_headlines_use_case.dart';

class ArticlesProvider extends ChangeNotifier {
  final GetTopHeadlinesUseCase _getTopHeadlinesUseCase;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  static const String fetchLatestArticlesTaskName = 'getLatestArticles';

  Exception? _exception;
  Exception? get exception => _exception;

  ArticlesProvider({required GetTopHeadlinesUseCase getTopHeadlinesUseCase})
      : _getTopHeadlinesUseCase = getTopHeadlinesUseCase;

  getLatestArticles({required String countryCode}) async {
    Result<List<Article>> articleResult = await _getTopHeadlinesUseCase.invoke(countryCode: countryCode);
    if(articleResult is SuccessResult) {
      _articles = (articleResult as SuccessResult<List<Article>>).data;
      _exception = null;
    } else {
      _exception = (articleResult as ErrorResult).exception;
    }
    notifyListeners();
  }
}