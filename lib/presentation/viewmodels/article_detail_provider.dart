import 'package:flutter/foundation.dart';
import 'package:news_client/domain/models/article.dart';
import 'package:news_client/domain/use_cases/is_article_saved_use_case.dart';

class ArticleDetailProvider extends ChangeNotifier {
  final IsArticleSavedUseCase _isArticleSavedUseCase;

  late Article _currentArticle;
  Article get currentArticle => _currentArticle;

  bool _isCurrentArticleSaved = false;
  bool get isCurrentArticleSaved => _isCurrentArticleSaved;

  ArticleDetailLoadingState _loadingState = ArticleDetailLoadingState.notStarted;
  ArticleDetailLoadingState get loadingState => _loadingState;

  ArticleDetailProvider({required IsArticleSavedUseCase isArticleSavedUseCase})
      : _isArticleSavedUseCase = isArticleSavedUseCase;

  setCurrentArticle({required Article article}) async {
    _currentArticle = article;
    await checkIfCurrentArticleIsSaved();
    notifyListeners();
  }

  checkIfCurrentArticleIsSaved() async {
    _isCurrentArticleSaved = await _isArticleSavedUseCase.invoke(article: _currentArticle);
    notifyListeners();
  }

  setLoadingState({required ArticleDetailLoadingState loadingState}) {
    _loadingState = loadingState;
    notifyListeners();
  }
}

enum ArticleDetailLoadingState {
  notStarted,
  inProgress,
  finished
}