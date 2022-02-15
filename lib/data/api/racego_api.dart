import 'dart:io';
import 'package:http/http.dart' as http;

class RacegoApi {
  RacegoApi(this._client);
  Map<String, String> headers = {};
  static const String _apiBaseUrl = 'http://localhost/api.php/';

  final http.Client _client;


  void _updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      setCookie((index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
  }

  void setCookie(String cookie) => headers['cookie'] = cookie;
}
