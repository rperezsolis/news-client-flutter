import 'package:flutter/material.dart';
import 'package:news_client/data/datasources/local/database/database.dart';
import 'package:news_client/data/datasources/local/dao/saved_article_dao.dart';
import 'package:news_client/data/datasources/local/saved_article_local_datasource.dart';
import 'package:news_client/data/datasources/remote/article_remote_datasource.dart';
import 'package:news_client/data/datasources/remote/network_api/articles_network_api.dart';
import 'package:news_client/data/repositories/article_repository.dart';
import 'package:news_client/domain/use_cases/get_saved_articles_use_case.dart';
import 'package:news_client/domain/use_cases/get_top_headlines_use_case.dart';
import 'package:news_client/domain/use_cases/is_article_saved_use_case.dart';
import 'package:news_client/domain/use_cases/save_article_use_case.dart';
import 'package:news_client/domain/use_cases/unsave_article_use_case.dart';
import 'package:news_client/presentation/viewmodels/article_detail_provider.dart';
import 'package:news_client/presentation/viewmodels/articles_provider.dart';
import 'package:news_client/presentation/viewmodels/saved_articles_provider.dart';
import 'package:news_client/presentation/widgets/article_feed_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const NewsClientApp());
}

class NewsClientApp extends StatelessWidget {
  const NewsClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ArticlesProvider>(
          create: (_) => ArticlesProvider(
              getTopHeadlinesUseCase: GetTopHeadlinesUseCase(
                  articleRepository: ArticleRepository(
                      remoteDatasource: const ArticleRemoteDatasource(articlesNetworkApi: ArticlesNetworkApi.instance),
                      savedArticleLocalDatasource: SavedArticleLocalDatasource(
                          savedArticleDao: SavedArticleDAO(database: Database.instance)
                      )
                  )
              )
          ),
          lazy: true,
        ),
        ChangeNotifierProvider<ArticleDetailProvider>(create: (_) => ArticleDetailProvider(
            isArticleSavedUseCase: IsArticleSavedUseCase(
                articleRepository: ArticleRepository(
                    remoteDatasource: const ArticleRemoteDatasource(articlesNetworkApi: ArticlesNetworkApi.instance),
                    savedArticleLocalDatasource: SavedArticleLocalDatasource(
                        savedArticleDao: SavedArticleDAO(database: Database.instance)
                    )
                )
            )
        )),
        ChangeNotifierProvider<SavedArticlesProvider>(create: (_) => SavedArticlesProvider(
            saveArticleUseCase: SaveArticleUseCase(
                articleRepository: ArticleRepository(
                    remoteDatasource: const ArticleRemoteDatasource(articlesNetworkApi: ArticlesNetworkApi.instance),
                    savedArticleLocalDatasource: SavedArticleLocalDatasource(
                        savedArticleDao: SavedArticleDAO(database: Database.instance)
                    )
                )
            ),
            getSavedArticlesUseCase: GetSavedArticlesUseCase(
                articleRepository: ArticleRepository(
                    remoteDatasource: const ArticleRemoteDatasource(articlesNetworkApi: ArticlesNetworkApi.instance),
                    savedArticleLocalDatasource: SavedArticleLocalDatasource(
                        savedArticleDao: SavedArticleDAO(database: Database.instance)
                    )
                )
            ),
            unSaveArticleUseCase: UnSaveArticleUseCase(
                articleRepository: ArticleRepository(
                    remoteDatasource: const ArticleRemoteDatasource(articlesNetworkApi: ArticlesNetworkApi.instance),
                    savedArticleLocalDatasource: SavedArticleLocalDatasource(
                        savedArticleDao: SavedArticleDAO(database: Database.instance)
                    )
                )
            ))
        )
      ],
      child: MaterialApp(
        title: 'News Client',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(title: 'News Client'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ArticleFeedScreen(title: title,);
  }
}
