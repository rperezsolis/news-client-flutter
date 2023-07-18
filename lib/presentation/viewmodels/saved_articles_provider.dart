import 'package:flutter/foundation.dart';
import 'package:news_client/domain/models/article.dart';
import 'package:news_client/domain/use_cases/get_saved_articles_use_case.dart';
import 'package:news_client/domain/use_cases/save_article_use_case.dart';
import 'package:news_client/domain/use_cases/unsave_article_use_case.dart';

class SavedArticlesProvider extends ChangeNotifier {
  final SaveArticleUseCase _saveArticleUseCase;
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final UnSaveArticleUseCase _unSaveArticleUseCase;

  List<Article> _savedArticles = [];
  List<Article> get savedArticles => _savedArticles;

  Article? _latestDeletedArticle;
  Article? get latestDeletedArticle => _latestDeletedArticle;

  SavedArticlesProvider({
    required SaveArticleUseCase saveArticleUseCase,
    required GetSavedArticlesUseCase getSavedArticlesUseCase,
    required UnSaveArticleUseCase unSaveArticleUseCase})
      : _getSavedArticlesUseCase = getSavedArticlesUseCase,
        _saveArticleUseCase = saveArticleUseCase,
        _unSaveArticleUseCase = unSaveArticleUseCase;

  Future<int> saveArticle({required Article article}) async {
    int id = await _saveArticleUseCase.invoke(article: article);
    await getSavedArticles();
    notifyListeners();
    return id;
  }

  Future<int> unSaveArticle({required Article article}) async {
    int deletedRows = await _unSaveArticleUseCase.invoke(url: article.url);
    await getSavedArticles();
    _latestDeletedArticle = article;
    notifyListeners();
    return deletedRows;
  }

  getSavedArticles() async {
    _savedArticles = await _getSavedArticlesUseCase.invoke();
    notifyListeners();
  }
}