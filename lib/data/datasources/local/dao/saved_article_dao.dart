import 'package:drift/drift.dart';
import 'package:news_client/data/datasources/local/database/database.dart';

class SavedArticleDAO {
  final Database _database;

  SavedArticleDAO({required Database database}) : _database = database;

  Future<List<SavedArticle>> getSavedArticles() async {
    return await (_database.select(_database.savedArticles)).get();
  }

  Future<SavedArticle?> getSavedArticleByUrl({required String url}) async {
    return await (_database.select(_database.savedArticles)..where((savedArticle) =>
        savedArticle.url.equals(url))).getSingleOrNull();
  }

  Future<int> insertSavedArticle({required String title, required String description,
    required String content, required String url, String? author, String? source}) async {
    return await _database.into(_database.savedArticles).insert(
        SavedArticlesCompanion(
            title: Value(title),
            description: Value(description),
            content: Value(content),
            url: Value(url),
            author: Value(author),
            source: Value(source)
        ),
        mode: InsertMode.replace
    );
  }

  Future<int> deleteSavedArticleByUrl({required String url}) async {
    return await (_database.delete(_database.savedArticles)..where((table) => table.url.equals(url))).go();
  }
}