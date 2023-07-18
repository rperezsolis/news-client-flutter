import 'package:flutter/material.dart';
import 'package:news_client/domain/models/article.dart';
import 'package:news_client/presentation/viewmodels/article_detail_provider.dart';
import 'package:news_client/presentation/viewmodels/saved_articles_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String title;

  const ArticleDetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.disabled);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ArticleDetailProvider articleDetailProvider = context.read<ArticleDetailProvider>();
      webViewController.setNavigationDelegate(NavigationDelegate(
          onPageStarted: (String url) {
            articleDetailProvider.setLoadingState(loadingState: ArticleDetailLoadingState.inProgress);
          },
          onPageFinished: (String url) {
            articleDetailProvider.setLoadingState(loadingState: ArticleDetailLoadingState.finished);
          }
      ));
      Article article = articleDetailProvider.currentArticle;
      webViewController.loadRequest(Uri.parse(article.url));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Consumer2<ArticleDetailProvider, SavedArticlesProvider>(
            builder: (_, articleDetailProvider, savedArticlesProvider, __) {
              if(articleDetailProvider.isCurrentArticleSaved) {
                return IconButton(
                    onPressed: () {
                      savedArticlesProvider.unSaveArticle(article: articleDetailProvider.currentArticle);
                      articleDetailProvider.checkIfCurrentArticleIsSaved();
                    },
                    icon: const Icon(Icons.bookmark_added)
                );
              } else {
                return IconButton(
                    onPressed: () {
                      savedArticlesProvider.saveArticle(article: articleDetailProvider.currentArticle);
                      articleDetailProvider.checkIfCurrentArticleIsSaved();
                    },
                    icon: const Icon(Icons.bookmark_add_outlined)
                );
              }
            },
          )
        ],
      ),
      body: Consumer<ArticleDetailProvider>(
        builder: (_, articleDetailProvider, __) {
          if(articleDetailProvider.loadingState == ArticleDetailLoadingState.finished) {
            return WebViewWidget(
              controller: webViewController,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
