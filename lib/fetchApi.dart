import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'd3ccbe6';
const String omdbUrl = 'http://omdbapi.com/?apikey=$apiKey&';
const String imdbUrl = 'https://v2.sg.media-imdb.com/suggestion/';

Future<ApiResponse> fetchApi(String type, String target) async {
  var httpResponse;
  String reqUrl = '';

  switch (type) {
    case 'search':
      reqUrl = imdbUrl + target.substring(0, 1).toLowerCase() + '/$target.json';
      break;
    case 'select':
      reqUrl = omdbUrl + 'i=$target';
      break;
  }

  httpResponse = await http.get(Uri.parse(reqUrl));

  return ApiResponse(httpResponse.statusCode,
      httpResponse.statusCode == 200 ? jsonDecode(httpResponse.body) : 'error');
}

class ApiResponse {
  dynamic status;
  dynamic body;

  ApiResponse(dynamic status, dynamic body) {
    this.status = status;
    this.body = body;
  }
}
