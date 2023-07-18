import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/models/article.dart';
import 'package:news_client/domain/use_cases/get_saved_articles_use_case.dart';

class MockArticleRepository extends Mock implements ArticleRepository{}

void main() {
  group('GetSavedArticlesUseCase', () {
    late ArticleRepository mockArticleRepository;

    setUp(() {
      mockArticleRepository = MockArticleRepository();
    });

    test('GetSavedArticlesUseCase returns a list of articles', () async {
      final GetSavedArticlesUseCase getSavedArticlesUseCase = GetSavedArticlesUseCase(articleRepository: mockArticleRepository);
      const List<SavedArticle> savedArticles = [
        SavedArticle(id: 1, title: 'title 1', description: 'description 1', content: 'content 1', url: 'url 1'),
        SavedArticle(id: 2, title: 'title 2', description: 'description 2', content: 'content 2', url: 'url 2')
      ];
      when(() => mockArticleRepository.getSavedArticles()).thenAnswer((_) async => savedArticles);
      List<Article> actualResult = await getSavedArticlesUseCase.invoke();
      expect(actualResult[0].title == savedArticles[0].title && actualResult[0].description == savedArticles[0].description, true);
      expect(actualResult[1].content == savedArticles[1].content && actualResult[1].url == savedArticles[1].url, true);
    });
  });
}