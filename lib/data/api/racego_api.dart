import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:racego/data/models/user.dart';
import 'package:racego/data/models/userdetails.dart';
import 'package:racego/ui/widgets/timeinput.dart';

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
      if (!kIsWeb) {
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

  Future<List<User>> getUser() async {
    try {
      String response = await _getRequest(_apiBaseUrl + 'v1/user');
      List<dynamic> users = jsonDecode(response);
      List<User> userList = users.map((e) => User.fromJson(e)).toList();
      return userList;
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

  Future<List<User>> getTrack() async {
    try {
      String response = await _getRequest(_apiBaseUrl + 'v1/track');
      List<dynamic> users = jsonDecode(response);
      List<User> userList = users.map((e) => User.fromJson(e)).toList();
      return userList;
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
        'Unbekannter Fehler',
        error.toString(),
        error.runtimeType.toString(),
      );
    }
  }

  Future<UserDetails> getUserDetails(int id) async {
    try {
      String response =
          await _getRequest(_apiBaseUrl + 'v1/user/' + id.toString());
      return UserDetails.fromJson(jsonDecode(response));
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

  Future<bool> setUserDetails(UserDetails user) async {
    try {
      if (user.id <= 0 || user.firstName.isEmpty || user.lastName.isEmpty) {
        throw DataException('Die Benutzerangaben sind ungenügend');
      }

      String response = await _putRequest(
          _apiBaseUrl + 'v1/user/' + user.id.toString(),
          jsonEncode(user.toJson()));
      Map<String, dynamic> map = jsonDecode(response);
      if (map.keys.contains('result') && map['result'] == 'successful') {
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

  Future<int> addUser(UserDetails user) async {
    try {
      if (user.firstName.isEmpty || user.lastName.isEmpty) {
        throw DataException('Die Benutzerangaben sind ungenügend');
      }

      String response = await _postRequest(
          _apiBaseUrl + 'v1/user/', jsonEncode(user.toJson()));
      Map<String, dynamic> map = jsonDecode(response);
      if (map.keys.contains('inserted_id') && map['inserted_id'] > 0) {
        return map['inserted_id'];
      }
      return 0;
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

  Future<bool> deleteUser(int userId) async {
    try {
      Map<String, int> bodyMap = {'id': userId};
      String body = jsonEncode(bodyMap);
      String response = await _deleteRequest(_apiBaseUrl + 'v1/user', body);
      Map<String, dynamic> map = jsonDecode(response);

      if (map.keys.contains('result') && map['result'] == 'successful') {
        return true;
      } else {
        return false;
      }
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
        'Unbekannter Fehler',
        error.toString(),
        error.runtimeType.toString(),
      );
    }
  }

  Future<bool> addOnTrack(int userId) async {
    try {
      Map<String, int> bodyMap = {'id': userId};
      String body = jsonEncode(bodyMap);
      String response = await _postRequest(_apiBaseUrl + 'v1/ontrack', body);
      Map<String, dynamic> map = jsonDecode(response);
      if (map.keys.contains('result') && map['result'] == 'successful') {
        return true;
      } else {
        return false;
      }
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
        'Unbekannter Fehler',
        error.toString(),
        error.runtimeType.toString(),
      );
    }
  }

  Future<bool> cancelLap(int userId) async {
    try {
      Map<String, int> bodyMap = {'id': userId};
      String body = jsonEncode(bodyMap);
      String response = await _deleteRequest(_apiBaseUrl + 'v1/ontrack', body);
      Map<String, dynamic> map = jsonDecode(response);
      if (map.keys.contains('affected_rows') && map['affected_rows'] > 0) {
        return true;
      } else {
        return false;
      }
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
        'Unbekannter Fehler',
        error.toString(),
        error.runtimeType.toString(),
      );
    }
  }

  Future<bool> finishLap(int userId, Time time) async {
    try {
      if (!time.isValid) return false;
      Map<String, dynamic> bodyMap = {'id': userId, 'time': time.toTimeString};
      String body = jsonEncode(bodyMap);
      String response = await _putRequest(_apiBaseUrl + 'v1/ontrack', body);
      Map<String, dynamic> map = jsonDecode(response);
      if (map.keys.contains('result') && map['result'] == 'successful') {
        return true;
      } else {
        return false;
      }
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
        'Unbekannter Fehler',
        error.toString(),
        error.runtimeType.toString(),
      );
    }
  }

  Future<List<String>> getCategories() async {
    try {
      String response = await _getRequest(_apiBaseUrl + 'v1/categories');
      List<dynamic> users = jsonDecode(response);
      return users.map((e) => e as String).toList();
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

  Future<String> _putRequest(String url, Object? body) async {
    try {
      http.Response response =
          await _client.put(Uri.parse(url), body: body, headers: headers);
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

  Future<String> _deleteRequest(String url, Object? body) async {
    try {
      http.Response response =
          await _client.delete(Uri.parse(url), body: body, headers: headers);
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
