import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';
import 'package:news_client/domain/use_cases/is_article_saved_use_case.dart';

class MockArticleRepository extends Mock implements ArticleRepository{}

void main() {
  group('IsArticleSavedUseCase', () {
    late ArticleRepository mockArticleRepository;

    setUp(() {
      mockArticleRepository = MockArticleRepository();
    });

    test('IsArticleSavedUseCase returns true', () async {
      final IsArticleSavedUseCase isArticleSavedUseCase = IsArticleSavedUseCase(articleRepository: mockArticleRepository);
      const Article article = Article(title: 'Title', description: 'description', content: 'content', url: 'url', urlToImage: 'urlToImage');
      when(() => mockArticleRepository.getSavedArticleByUrl(url: article.url))
          .thenAnswer((invocation) async => const SavedArticle(
          id: 1,
          title: 'title',
          description: 'description',
          content: 'content',
          url: 'url'
      ));
      bool actualResult = await isArticleSavedUseCase.invoke(article: article);
      expect(actualResult, true);
    });

    test('IsArticleSavedUseCase returns false', () async {
      final IsArticleSavedUseCase isArticleSavedUseCase = IsArticleSavedUseCase(articleRepository: mockArticleRepository);
      const Article article = Article(title: 'Title', description: 'description', content: 'content', url: 'url', urlToImage: 'urlToImage');
      when(() => mockArticleRepository.getSavedArticleByUrl(url: article.url))
          .thenAnswer((invocation) async => null);
      bool actualResult = await isArticleSavedUseCase.invoke(article: article);
      expect(actualResult, false);
    });
  });
}

