import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/datasources/local/saved_article_local_datasource.dart';
import 'package:news_client/data/datasources/remote/article_remote_datasource.dart';
import 'package:news_client/data/models/article_response.dart';
import 'package:news_client/data/models/result.dart';

class ArticleRepository {
  final ArticleRemoteDatasource _remoteDatasource;
  final SavedArticleLocalDatasource _savedArticleLocalDatasource;

  const ArticleRepository({
    required ArticleRemoteDatasource remoteDatasource,
    required SavedArticleLocalDatasource savedArticleLocalDatasource})
      : _savedArticleLocalDatasource = savedArticleLocalDatasource,
        _remoteDatasource = remoteDatasource;

  Future<Result<ArticleResponse>> getTopHeadlines({required String countryCode}) async {
    return _remoteDatasource.getTopHeadlines(countryCode: countryCode);
  }

  Future<List<SavedArticle>> getSavedArticles() async {
    return await _savedArticleLocalDatasource.getSavedArticles();
  }

  Future<SavedArticle?> getSavedArticleByUrl({required String url}) async {
    return await _savedArticleLocalDatasource.getSavedArticleByUrl(url: url);
  }

  Future<int> saveArticle({required String title, required String description,
    required String content, required String url, String? author, String? source,
    String? urlToImage}) async {
    return await _savedArticleLocalDatasource.saveArticle(title: title, description: description,
        content: content, url: url, author: author, source: source, urlToImage: urlToImage);
  }

  Future<int> unSaveArticle({required String url}) async {
    return await _savedArticleLocalDatasource.unSaveArticle(url: url);
  }
}