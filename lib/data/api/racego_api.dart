import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:racego/data/exceptions/racego_exception.dart';

class RacegoApi {
  RacegoApi(this._client);
  Map<String, String> headers = {};
  static const String _apiBaseUrl = 'http://localhost/api.php/';

  final http.Client _client;


  Future<String> _postRequest(String url, Object? body) async {
    try {
      http.Response response =
          await _client.post(Uri.parse(url), body: body, headers: headers);
      _updateCookie(response);

      switch (response.statusCode) {
        case 200:
          return response.body;
        case 401:
          throw AuthException('Keine Berechtigung');
        case 404:
          throw ServerException(
              'Fehler: Fehlerhafte Quelle für den Datenaustausch.');
        case 409:
          throw DataException('Konflikt bei den gesendeten Daten');
        case 422:
          throw DataException('Eingabe konnte nicht verarbeitet werden');
        default:
          throw ServerException(
              'Serverantwort ungültig. Statuscode ${response.statusCode}');
      }
    } on RacegoException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      throw InternetException('Der Server kann nicht erreicht werden.');
    } catch (error) {
      throw UnknownException(
          'Unbekannter Fehler', error.toString(), error.runtimeType.toString());
    }
  }

  Future<String> _getRequest(String url) async {
    try {
      http.Response response =
          await _client.get(Uri.parse(url), headers: headers);
      _updateCookie(response);

      switch (response.statusCode) {
        case 200:
          return response.body;
        case 401:
          throw AuthException('Keine Berechtigung');
        case 404:
          throw ServerException(
              'Fehler: Fehlerhafte Quelle für den Datenaustausch.');
        case 409:
          throw DataException('Konflikt bei den gesendeten Daten');
        case 422:
          throw DataException('Eingabe konnte nicht verarbeitet werden');
        default:
          throw ServerException(
              'Serverantwort ungültig. Statuscode ${response.statusCode}');
      }
    } on RacegoException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      throw InternetException('Der Server kann nicht erreicht werden.');
    } catch (error) {
      throw UnknownException(
          'Unbekannter Fehler', error.toString(), error.runtimeType.toString());
    }
  }

  void _updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      setCookie((index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
  }

  void setCookie(String cookie) => headers['cookie'] = cookie;
}
