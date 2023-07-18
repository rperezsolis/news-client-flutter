import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/use_cases/unsave_article_use_case.dart';

class MockArticleRepository extends Mock implements ArticleRepository{}

void main() {
  group('UnSaveArticleUseCase', () {
    late ArticleRepository mockArticleRepository;

    setUp(() {
      mockArticleRepository = MockArticleRepository();
    });

    test('UnSaveArticleUseCase returns the amount of unsaved articles', () async {
      final UnSaveArticleUseCase unSaveArticleUseCase = UnSaveArticleUseCase(articleRepository: mockArticleRepository);
      const String url = 'url';
      const amount = 1;
      when(() => mockArticleRepository.unSaveArticle(url: url)).thenAnswer((_) async => amount);
      int actualResult = await unSaveArticleUseCase.invoke(url: url);
      expect(actualResult, amount);
    });
  });
}