import 'package:news_client/data/datasources/remote/network_constants.dart';
import 'package:news_client/data/models/article_response.dart';
import 'package:news_client/data/models/result.dart';
import 'package:http/http.dart' as http;

class ArticlesNetworkApi {
  static const String apiKey = newsApiKey;

  const ArticlesNetworkApi._create();

  static const ArticlesNetworkApi instance = ArticlesNetworkApi._create();

  Future<Result<ArticleResponse>> getTopHeadlines({required String countryCode}) async {
    Uri url = Uri.https(baseUrl, topHeadlinesEndpoint, {"country":countryCode});
    try {
      http.Response response = await http.get(url, headers: {"Authorization":apiKey});
      if(response.statusCode == 200) {
        ArticleResponse articleResponse = articleResponseFromJson(response.body);
        return SuccessResult(data: articleResponse);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on Exception catch(exception) {
      return ErrorResult(exception: exception);
    }
  }
}