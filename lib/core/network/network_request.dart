import 'package:pretty_http_logger/pretty_http_logger.dart';

class NetworkRequest {
  HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse(url), body: body);
    return response.body;
  }

  Future<dynamic> postWithQueryParams(String url,
      {Map<String, dynamic>? queryParams}) async {
    // Construct the URL with query parameters
    final uri = Uri.parse(url).replace(queryParameters: queryParams);

    // Make the POST request with no body
    final response = await http.post(uri);

    return response.body;
  }

  Future<dynamic> put(String url, Map<String, dynamic> body) async {
    final response = await http.put(Uri.parse(url), body: body);
    return response.body;
  }

  Future<dynamic> delete(String url) async {
    final response = await http.delete(Uri.parse(url));
    return response.body;
  }
}
