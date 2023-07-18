import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_client/data/datasources/local/dao/saved_article_dao.dart';
import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/datasources/local/saved_article_local_datasource.dart';

class MockSavedArticleDAO extends Mock implements SavedArticleDAO {}

void main() {
  group('SavedArticleLocalDatasource', () {
    late MockSavedArticleDAO mockSavedArticleDAO;

    setUp(() {
      mockSavedArticleDAO = MockSavedArticleDAO();
    });

    test('getSavedArticles returns a list of saved articles', () async {
      final SavedArticleLocalDatasource savedArticleLocalDatasource = SavedArticleLocalDatasource(savedArticleDao: mockSavedArticleDAO);
      const List<SavedArticle> savedArticles = [
        SavedArticle(id: 1, title: 'title 1', description: 'description 1', content: 'content 1', url: 'url 1'),
        SavedArticle(id: 2, title: 'title 2', description: 'description 2', content: 'content 2', url: 'url 2')
      ];
      when(() => mockSavedArticleDAO.getSavedArticles()).thenAnswer((_) async => savedArticles);
      List<SavedArticle> actualResult = await savedArticleLocalDatasource.getSavedArticles();
      expect(actualResult, savedArticles);
    });

    test('getSavedArticleByUrl returns a saved article', () async {
      final SavedArticleLocalDatasource savedArticleLocalDatasource = SavedArticleLocalDatasource(savedArticleDao: mockSavedArticleDAO);
      const String url = 'url';
      const SavedArticle savedArticle = SavedArticle(id: 1, title: 'title 1', description: 'description 1', content: 'content 1', url: 'url 1');
      when(() => mockSavedArticleDAO.getSavedArticleByUrl(url: url)).thenAnswer((_) async => savedArticle);
      SavedArticle? actualResult = await savedArticleLocalDatasource.getSavedArticleByUrl(url: url);
      expect(actualResult, savedArticle);
    });

    test('saveArticle returns the id of the saved article', () async {
      final SavedArticleLocalDatasource savedArticleLocalDatasource = SavedArticleLocalDatasource(savedArticleDao: mockSavedArticleDAO);
      const String title = 'title';
      const String description = 'description';
      const String content = 'content';
      const String url = 'url';
      const savedArticleId = 1;
      when(() => mockSavedArticleDAO.insertSavedArticle(title: title,
          description: description, content: content, url: url))
          .thenAnswer((_) async => savedArticleId);
      int actualResult = await savedArticleLocalDatasource.saveArticle(title: title,
          description: description, content: content, url: url);
      expect(actualResult, savedArticleId);
    });
  });
}