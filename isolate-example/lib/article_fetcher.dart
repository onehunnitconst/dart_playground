import 'package:dio/dio.dart';

class ArticleFetcher {
  final Dio _client;

  ArticleFetcher(String baseUrl)
      : _client = Dio(
          BaseOptions(
            baseUrl: baseUrl,
          ),
        );

  Future<Map<String, dynamic>> findArticle(int articleId) async {
    final response = await _client.get('articles/$articleId');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> findUser(int userId) async {
    final response = await _client.get('users/$userId');
    return response.data as Map<String, dynamic>;
  }
}
