import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/datasources/local/dao/saved_article_dao.dart';

class SavedArticleLocalDatasource {
  final SavedArticleDAO _savedArticleDao;

  const SavedArticleLocalDatasource({required SavedArticleDAO savedArticleDao}) : _savedArticleDao = savedArticleDao;

  Future<List<SavedArticle>> getSavedArticles() async {
    return await _savedArticleDao.getSavedArticles();
  }

  Future<SavedArticle?> getSavedArticleByUrl({required String url}) async {
    return await _savedArticleDao.getSavedArticleByUrl(url: url);
  }

  Future<int> saveArticle({required String title, required String description,
    required String content, required String url, String? author, String? source,
    String? urlToImage}) async {
    return await _savedArticleDao.insertSavedArticle(title: title, description: description,
        content: content, url: url, author: author, source: source, urlToImage: urlToImage);
  }

  Future<int> unSaveArticle({required String url}) async {
    return await _savedArticleDao.deleteSavedArticleByUrl(url: url);
  }
}