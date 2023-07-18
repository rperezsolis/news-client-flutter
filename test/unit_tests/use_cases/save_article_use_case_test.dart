import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';
import 'package:news_client/domain/use_cases/save_article_use_case.dart';

class MockArticleRepository extends Mock implements ArticleRepository{}

void main() {
  group('SaveArticleUseCase', () {
    late ArticleRepository mockArticleRepository;

    setUp(() {
      mockArticleRepository = MockArticleRepository();
    });

    test('SaveArticleUseCase returns the the saved article id', () async {
      final SaveArticleUseCase saveArticleUseCase = SaveArticleUseCase(articleRepository: mockArticleRepository);
      const Article article = Article(title: 'Article 1', description: 'Description 1', content: 'Content 1', url: 'Url 1', urlToImage: 'urlToImage');
      const int savedArticleId = 7;
      when(() => mockArticleRepository.saveArticle(title: article.title, description: article.description,
          content: article.content, url: article.url, urlToImage: article.urlToImage)).thenAnswer((_) async => savedArticleId);
      int actualResult = await saveArticleUseCase.invoke(article: article);
      expect(actualResult, savedArticleId);
    });
  });
}