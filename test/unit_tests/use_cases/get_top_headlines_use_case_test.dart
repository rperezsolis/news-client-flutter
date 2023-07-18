import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_client/data/models/article.dart' as data_article;
import 'package:news_client/data/models/article_response.dart';
import 'package:news_client/data/models/result.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';
import 'package:news_client/domain/use_cases/get_top_headlines_use_case.dart';

class MockArticleRepository extends Mock implements ArticleRepository{}

void main() {
  group('GetTopHeadlinesUseCase', () {
    late ArticleRepository mockArticleRepository;

    setUp(() {
      mockArticleRepository = MockArticleRepository();
    });

    test('GetTopHeadlinesUseCase retrieves a success result with a list of articles', () async {
      final GetTopHeadlinesUseCase getTopHeadlinesUseCase = GetTopHeadlinesUseCase(articleRepository: mockArticleRepository);
      const String countryCode = 'us';
      Result<ArticleResponse> articleResponseResult = const SuccessResult<ArticleResponse>(data: ArticleResponse(
          status: "status",
          totalResults: 2,
          articles: [
            data_article.Article(title: 'Article 1', description: 'Description 1', content: 'Content 1', url: 'Url 1', urlToImage: 'urlToImage'),
            data_article.Article(title: 'Article 2', description: 'Description 2', content: 'Content 2', url: 'Url 2', urlToImage: 'urlToImage')
          ])
      );
      SuccessResult<List<Article>> expectedResult = const SuccessResult<List<Article>>(data: [
        Article(title: 'Article 1', description: 'Description 1', content: 'Content 1', url: 'Url 1', urlToImage: 'urlToImage'),
        Article(title: 'Article 2', description: 'Description 2', content: 'Content 2', url: 'Url 2', urlToImage: 'urlToImage')
      ]);
      when(() => mockArticleRepository.getTopHeadlines(countryCode: countryCode))
          .thenAnswer((_) async => articleResponseResult);
      SuccessResult<List<Article>> actualResult = await getTopHeadlinesUseCase
          .invoke(countryCode: countryCode) as SuccessResult<List<Article>>;
      expect(actualResult.data[0], expectedResult.data[0]);
      expect(actualResult.data[1], expectedResult.data[1]);
    });

    test('GetTopHeadlinesUseCase only retrieves articles with non null title, description, content, and url', () async {
      final GetTopHeadlinesUseCase getTopHeadlinesUseCase = GetTopHeadlinesUseCase(articleRepository: mockArticleRepository);
      const String countryCode = 'us';
      Result<ArticleResponse> articleResponseResult = const SuccessResult<ArticleResponse>(data: ArticleResponse(
          status: "status",
          totalResults: 2,
          articles: [
            data_article.Article(title: 'Article 1', description: 'Description 1', content: 'Content 1', url: 'Url 1', urlToImage: 'urlToImage'),
            data_article.Article(title: 'Article 2', description: null, content: 'Content 2', url: 'Url 2', urlToImage: 'urlToImage'),
            data_article.Article(title: 'Article 3', description: 'Description 3', content: null, url: 'Url 3', urlToImage: 'urlToImage'),
            data_article.Article(title: 'Article 4', description: 'Description 4', content: 'Content 4', url: null, urlToImage: null)
          ])
      );
      SuccessResult<List<Article>> expectedResult = const SuccessResult<List<Article>>(data: [
        Article(title: 'Article 1', description: 'Description 1', content: 'Content 1', url: 'Url 1', urlToImage: 'urlToImage')
      ]);
      when(() => mockArticleRepository.getTopHeadlines(countryCode: countryCode))
          .thenAnswer((_) async => articleResponseResult);
      SuccessResult<List<Article>> actualResult = await getTopHeadlinesUseCase
          .invoke(countryCode: countryCode) as SuccessResult<List<Article>>;
      expect(actualResult.data.length, 1);
      expect(actualResult.data[0], expectedResult.data[0]);
    });

    test('GetTopHeadlinesUseCase retrieves an error result with an exception', () async {
      final GetTopHeadlinesUseCase getTopHeadlinesUseCase = GetTopHeadlinesUseCase(articleRepository: mockArticleRepository);
      const String countryCode = 'us';
      const String exceptionMessage = "Could not find host newsapi.org";
      when(() => mockArticleRepository.getTopHeadlines(countryCode: countryCode))
          .thenAnswer((_) async => const ErrorResult(exception: SocketException(exceptionMessage)));
      ErrorResult actualResult = await getTopHeadlinesUseCase.invoke(countryCode: countryCode) as ErrorResult<List<Article>>;
      expect(actualResult.exception.toString().contains(exceptionMessage), isTrue);
    });
  });
}