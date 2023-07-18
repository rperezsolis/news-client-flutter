import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/models/article.dart' as data_article;
import 'package:news_client/data/datasources/local/saved_article_local_datasource.dart';
import 'package:news_client/data/datasources/remote/article_remote_datasource.dart';
import 'package:news_client/data/models/article_response.dart';
import 'package:news_client/data/models/result.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';

class MockArticleRemoteDatasource extends Mock implements ArticleRemoteDatasource {}
class MockSavedArticleLocalDatasource extends Mock implements SavedArticleLocalDatasource {}

void main() {
  group('ArticleRepository', () {
    late MockArticleRemoteDatasource mockArticleRemoteDatasource;
    late MockSavedArticleLocalDatasource mockSavedArticleLocalDatasource;

    setUp(() {
      mockArticleRemoteDatasource = MockArticleRemoteDatasource();
      mockSavedArticleLocalDatasource = MockSavedArticleLocalDatasource();
    });

    test('getTopHeadlines returns a success result with an article response ', () async {
      final ArticleRepository articleRepository = ArticleRepository(remoteDatasource: mockArticleRemoteDatasource,
          savedArticleLocalDatasource: mockSavedArticleLocalDatasource);
      const String countryCode = 'us';
      Result<ArticleResponse> articleResponseResult = const SuccessResult<ArticleResponse>(data: ArticleResponse(
          status: "status",
          totalResults: 2,
          articles: [
            data_article.Article(title: 'Article 1', description: 'Description 1', content: 'Content 1', url: 'Url 1'),
            data_article.Article(title: 'Article 2', description: 'Description 2', content: 'Content 2', url: 'Url 2')
          ])
      );
      when(() => mockArticleRemoteDatasource.getTopHeadlines(countryCode: countryCode))
          .thenAnswer((_) async => articleResponseResult);
      Result<ArticleResponse> actualResult = await articleRepository.getTopHeadlines(countryCode: countryCode);
      expect(actualResult, articleResponseResult);
    });

    test('getSavedArticles returns a list of saved articles', () async {
      final ArticleRepository articleRepository = ArticleRepository(remoteDatasource: mockArticleRemoteDatasource,
          savedArticleLocalDatasource: mockSavedArticleLocalDatasource);
      const List<SavedArticle> savedArticles = [
        SavedArticle(id: 1, title: 'title 1', description: 'description 1', content: 'content 1', url: 'url 1'),
        SavedArticle(id: 2, title: 'title 2', description: 'description 2', content: 'content 2', url: 'url 2')
      ];
      when(() => mockSavedArticleLocalDatasource.getSavedArticles()).thenAnswer((_) async => savedArticles);
      List<SavedArticle> actualResult = await articleRepository.getSavedArticles();
      expect(actualResult, savedArticles);
    });

    test('getSavedArticleByUrl returns a saved article', () async {
      final ArticleRepository articleRepository = ArticleRepository(remoteDatasource: mockArticleRemoteDatasource,
          savedArticleLocalDatasource: mockSavedArticleLocalDatasource);
      const String url = 'url';
      const SavedArticle savedArticle = SavedArticle(id: 1, title: 'title 1', description: 'description 1', content: 'content 1', url: 'url 1');
      when(() => mockSavedArticleLocalDatasource.getSavedArticleByUrl(url: url)).thenAnswer((_) async => savedArticle);
      SavedArticle? actualResult = await articleRepository.getSavedArticleByUrl(url: url);
      expect(actualResult, savedArticle);
    });

    test('saveArticle returns the id of the saved article', () async {
      final ArticleRepository articleRepository = ArticleRepository(remoteDatasource: mockArticleRemoteDatasource,
          savedArticleLocalDatasource: mockSavedArticleLocalDatasource);
      const Article article = Article(title: 'title', description: 'description', content: 'content', url: 'url');
      const savedArticleId = 1;
      when(() => mockSavedArticleLocalDatasource.saveArticle(title: article.title,
          description: article.description, content: article.content, url: article.url))
          .thenAnswer((_) async => savedArticleId);
      int actualResult = await articleRepository.saveArticle(title: article.title,
          description: article.description, content: article.content, url: article.url);
      expect(actualResult, savedArticleId);
    });
  });
}