import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_client/data/models/article.dart' as data_article;
import 'package:news_client/data/datasources/remote/article_remote_datasource.dart';
import 'package:news_client/data/datasources/remote/network_api/articles_network_api.dart';
import 'package:news_client/data/models/article_response.dart';
import 'package:news_client/data/models/result.dart';

class MockArticlesNetworkApi extends Mock implements ArticlesNetworkApi {}

void main() {
  group('ArticleRemoteDatasource', () {
    late MockArticlesNetworkApi mockArticlesNetworkApi;

    setUp(() {
      mockArticlesNetworkApi = MockArticlesNetworkApi();
    });

    test('getTopHeadlines returns a result with an article response ', () async {
      final ArticleRemoteDatasource articleRemoteDatasource = ArticleRemoteDatasource(articlesNetworkApi: mockArticlesNetworkApi);
      const String countryCode = 'us';
      Result<ArticleResponse> articleResponseResult = const SuccessResult<ArticleResponse>(data: ArticleResponse(
          status: "status",
          totalResults: 2,
          articles: [
            data_article.Article(title: 'Article 1', description: 'Description 1', content: 'Content 1', url: 'Url 1'),
            data_article.Article(title: 'Article 2', description: 'Description 2', content: 'Content 2', url: 'Url 2')
          ])
      );
      when(() => mockArticlesNetworkApi.getTopHeadlines(countryCode: countryCode))
          .thenAnswer((_) async => articleResponseResult);
      Result<ArticleResponse> actualResult = await articleRemoteDatasource.getTopHeadlines(countryCode: countryCode);
      expect(actualResult, articleResponseResult);
    });

    test('getTopHeadlines returns a result with an exception', () async {
      final ArticleRemoteDatasource articleRemoteDatasource = ArticleRemoteDatasource(articlesNetworkApi: mockArticlesNetworkApi);
      const String countryCode = 'us';
      const String exceptionMessage = "Could not find host newsapi.org";
      when(() => mockArticlesNetworkApi.getTopHeadlines(countryCode: countryCode))
          .thenAnswer((_) async => const ErrorResult(exception: SocketException(exceptionMessage)));
      ErrorResult actualResult = await articleRemoteDatasource.getTopHeadlines(countryCode: countryCode) as ErrorResult<ArticleResponse>;
      expect(actualResult.exception.toString().contains(exceptionMessage), isTrue);
    });
  });
}