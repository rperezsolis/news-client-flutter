import 'package:news_client/data/datasources/remote/network_api/articles_network_api.dart';
import 'package:news_client/data/models/article_response.dart';
import 'package:news_client/data/models/result.dart';

class ArticleRemoteDatasource {
  final ArticlesNetworkApi _articlesNetworkApi;

  const ArticleRemoteDatasource({required ArticlesNetworkApi articlesNetworkApi}) :
        _articlesNetworkApi = articlesNetworkApi;

  Future<Result<ArticleResponse>> getTopHeadlines({required String countryCode}) async {
    return await _articlesNetworkApi.getTopHeadlines(countryCode: countryCode);
  }
}