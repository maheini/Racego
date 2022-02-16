import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RacegoApi {
  String? _username;
  bool _isLoggedIn = false;
  FlutterSecureStorage secureStorage;
  RacegoApi(this._client, this.secureStorage);
  Map<String, String> headers = {};
  static const String _apiBaseUrl = 'http://localhost/api.php/';

  final http.Client _client;

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username ?? '';

  Future<bool> regenerateSession() async {
    try {
      if (kIsWeb) {
        // if platform is not web ->set cookie
        String? cookie = await secureStorage.read(key: 'racego_cookie');
        if (cookie != null) setCookie(cookie);
      }

      Map<String, dynamic> status =
          jsonDecode(await _getRequest(_apiBaseUrl + 'me'));
      if (status.containsKey('username')) {
        _username = status['username'];
        _isLoggedIn = true;
        return true;
      }
      return false;
    } on AuthException catch (_) {
      return false;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException('Fehler beim Parsen der Serverantwort');
    } on FormatException catch (_) {
      throw DataException('Fehler beim Parsen der Serverantwort');
    } catch (error) {
      throw UnknownException(
          'Unbekannter Fehler', error.toString(), error.runtimeType.toString());
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      Map<String, String> loginData = {
        'username': username,
        'password': password
      };
      String response = await _postRequest(_apiBaseUrl + 'login', loginData);
      Map<String, dynamic> data = jsonDecode(response);
      if (data.containsKey('username')) {
        _username = data['username'];
        _isLoggedIn = true;
        return true;
      }
      return false;
    } on AuthException catch (authError) {
      if (authError.errorMessage.contains('Login fehlgeschlagen')) {
        return false;
      } else {
        rethrow;
      }
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException('Fehler beim Parsen der Serverantwort');
    } on FormatException catch (_) {
      throw DataException('Fehler beim Parsen der Serverantwort');
    } catch (error) {
      throw UnknownException(
          'Unbekannter Fehler', error.toString(), error.runtimeType.toString());
    }
  }

  Future<bool> logout() async {
    try {
      String response = await _postRequest(_apiBaseUrl + 'logout', '');
      Map<String, dynamic> data = jsonDecode(response);
      if (data.containsKey('username')) {
        _username = null;
        _isLoggedIn = false;
        return true;
      }
      return false;
    } on AuthException catch (_) {
      rethrow;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException('Fehler beim Parsen der Serverantwort');
    } on FormatException catch (_) {
      throw DataException('Fehler beim Parsen der Serverantwort');
    } catch (error) {
      throw UnknownException(
          'Unbekannter Fehler', error.toString(), error.runtimeType.toString());
    }
  }

  Future<String> _postRequest(String url, Object? body) async {
    try {
      http.Response response =
          await _client.post(Uri.parse(url), body: body, headers: headers);
      _updateCookie(response);

      switch (response.statusCode) {
        case 200:
          return response.body;
        case 401:
          _isLoggedIn = false;
          _username = null;
          throw AuthException('Keine Berechtigung');
        case 403:
          _isLoggedIn = false;
          _username = null;
          throw AuthException('Login fehlgeschlagen');
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
    } on TimeoutException catch (_) {
      throw InternetException(
          'Der Server kann nicht erreicht werden: Timeout.');
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
          _isLoggedIn = false;
          _username = null;
          throw AuthException('Keine Berechtigung');
        case 403:
          _isLoggedIn = false;
          _username = null;
          throw AuthException('Login Fehlgeschlagen');
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
    } on TimeoutException catch (_) {
      throw InternetException(
          'Der Server kann nicht erreicht werden: Timeout.');
    } catch (error) {
      throw UnknownException(
          'Unbekannter Fehler', error.toString(), error.runtimeType.toString());
    }
  }

  void _updateCookie(http.Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      String cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      setCookie(cookie);
      if (!kIsWeb) {
        // is platform not web?
        await secureStorage.write(key: 'racego_cookie', value: cookie);
      }
    }
  }

  void setCookie(String cookie) => headers['cookie'] = cookie;
}
