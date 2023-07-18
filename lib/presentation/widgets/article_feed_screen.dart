import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_client/presentation/viewmodels/article_detail_provider.dart';
import 'package:news_client/presentation/viewmodels/articles_provider.dart';
import 'package:news_client/presentation/widgets/article_detail_screen.dart';
import 'package:news_client/presentation/widgets/saved_articles_screen.dart';
import 'package:provider/provider.dart';

class ArticleFeedScreen extends StatefulWidget {
  final String title;

  const ArticleFeedScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ArticleFeedScreen> createState() => _ArticleFeedScreenState();
}

class _ArticleFeedScreenState extends State<ArticleFeedScreen> {
  late ArticlesProvider articlesProvider;
  late ArticleDetailProvider articleDetailProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Locale locale = View.of(context).platformDispatcher.locale;
      articlesProvider = context.read<ArticlesProvider>()
        ..getLatestArticles(countryCode: locale.countryCode ?? "us");
      articleDetailProvider = context.read<ArticleDetailProvider>();
      Timer.periodic(const Duration(minutes: 5), (Timer timer) {
        articlesProvider.getLatestArticles(countryCode: locale.countryCode ?? "us");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) => SavedArticlesScreen(title: widget.title),)
                );
              },
              icon: const Icon(Icons.bookmark_outline)
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final Locale locale = View.of(context).platformDispatcher.locale;
          articlesProvider.getLatestArticles(countryCode: locale.countryCode ?? "us");
        },
        child: Consumer<ArticlesProvider>(
          builder: (_, articleProvider, __) {
            return getRefreshIndicatorChild(articleProvider: articleProvider);
          },
        ),
      ),
    );
  }

  Widget getRefreshIndicatorChild({required ArticlesProvider articleProvider}) {
    switch(articleProvider.articles.length) {
      case 0: return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if(articleProvider.exception == null) {
            return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: CircularProgressIndicator(),
                )
            );
          } else {
            return Center(child: Text("An error occurred\n${articleProvider.exception?.toString()}"));
          }
        },
        itemCount: 1,
      );
      default: return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              articleProvider.articles[index].title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              articleProvider.articles[index].description,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            leading: articleProvider.articles[index].urlToImage != null
                ? AspectRatio(
                    aspectRatio: 1/1,
                    child: Image.network(
                      articleProvider.articles[index].urlToImage!,
                      height: 64,
                      width: 64,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                : null,
            onTap: () {
              articleDetailProvider.setCurrentArticle(article: articleProvider.articles[index]);
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) => ArticleDetailScreen(title: widget.title),)
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemCount: articleProvider.articles.length,
      );
    }
  }
}
