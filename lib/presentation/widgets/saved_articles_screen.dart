import 'package:flutter/material.dart';
import 'package:news_client/presentation/viewmodels/article_detail_provider.dart';
import 'package:news_client/presentation/viewmodels/saved_articles_provider.dart';
import 'package:news_client/presentation/widgets/article_detail_screen.dart';
import 'package:provider/provider.dart';

class SavedArticlesScreen extends StatefulWidget {
  final String title;

  const SavedArticlesScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<SavedArticlesScreen> createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen> {
  late ArticleDetailProvider articleDetailProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SavedArticlesProvider>().getSavedArticles();
      articleDetailProvider = context.read<ArticleDetailProvider>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Saved Articles"),
      ),
      body: Consumer<SavedArticlesProvider>(
        builder: (_, savedArticlesProvider, __) {
          if(savedArticlesProvider.savedArticles.isNotEmpty) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    savedArticlesProvider.savedArticles[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    savedArticlesProvider.savedArticles[index].description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: savedArticlesProvider.savedArticles[index].urlToImage != null
                      ? AspectRatio(
                          aspectRatio: 1/1,
                          child: Image.network(
                            savedArticlesProvider.savedArticles[index].urlToImage!,
                            height: 64,
                            width: 64,
                            fit: BoxFit.fitHeight,
                          )
                        )
                      : null,
                  onTap: () {
                    articleDetailProvider.setCurrentArticle(article: savedArticlesProvider.savedArticles[index]);
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) => ArticleDetailScreen(title: widget.title),)
                    );
                  },
                  trailing: Consumer<ArticleDetailProvider>(
                    builder: (_, articleDetailProvider, __) {
                      return IconButton(
                          onPressed: () {
                            savedArticlesProvider.unSaveArticle(article: savedArticlesProvider.savedArticles[index]);
                            articleDetailProvider.checkIfCurrentArticleIsSaved();
                            SnackBar snackBar = SnackBar(
                              content: const Text('The article has been deleted.'),
                              action: SnackBarAction(
                                  label: "Undo",
                                  onPressed: () {
                                    if(savedArticlesProvider.latestDeletedArticle != null) {
                                      savedArticlesProvider.saveArticle(article: savedArticlesProvider.latestDeletedArticle!);
                                      articleDetailProvider.checkIfCurrentArticleIsSaved();
                                    }
                                  }
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          icon: const Icon(Icons.bookmark_added)
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: savedArticlesProvider.savedArticles.length,
            );
          } else {
            return const Center(
              child: Text("No articles saved yet"),
            );
          }
        },
      ),
    );
  }
}
