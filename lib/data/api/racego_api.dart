import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:racego/data/models/racedetails.dart';
import 'package:racego/data/models/rankinglist.dart';
import 'package:racego/data/models/time.dart';
import 'package:racego/data/models/user.dart';
import 'package:racego/data/models/userdetails.dart';

import '../../generated/l10n.dart';
import '../models/race.dart';

class RacegoApi {
  String? _username;
  bool _isLoggedIn = false;
  FlutterSecureStorage secureStorage;
  RacegoApi(this._client, this.secureStorage);
  Map<String, String> headers = {};
  static const String _apiBaseUrl = 'http://localhost/api.php/';

  final http.Client _client;

  int currentRaceId = 0;
  bool get isLoggedIn => _isLoggedIn;
  String get username => _username ?? '';

  Future<void> updateRaceId(int raceId) async {
    currentRaceId = raceId;
    headers['raceid'] = currentRaceId.toString();
    await secureStorage.write(
        key: 'racego_raceid_' + username, value: currentRaceId.toString());
  }

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

        // retrieve last raceid for the current user from secure storage
        currentRaceId = await secureStorage.read(
                key: 'racego_raceid_' + username) as int? ??
            0;
        headers['raceid'] = currentRaceId.toString();
        return true;
      }
      return false;
    } on AuthException catch (_) {
      return false;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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

        // retrieve last raceid for the current user from secure storage
        currentRaceId = int.parse(
            await secureStorage.read(key: 'racego_raceid_' + username) ?? '0');
        headers['raceid'] = currentRaceId.toString();
        return true;
      }
      return false;
    } on AuthException catch (authError) {
      if (authError.errorMessage.contains(S.current.failed_login)) {
        return false;
      } else {
        rethrow;
      }
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<bool> register(String username, String password) async {
    try {
      Map<String, String> loginData = {
        'username': username,
        'password': password
      };
      String response = await _postRequest(_apiBaseUrl + 'register', loginData);
      Map<String, dynamic> data = jsonDecode(response);
      if (data.containsKey('username')) {
        _username = data['username'];
        _isLoggedIn = true;

        // Set raceid to 0 for the new user
        currentRaceId = 0;
        headers['raceid'] = currentRaceId.toString();
        return true;
      }
      return false;
    } on AuthException catch (authError) {
      if (authError.errorMessage.contains(S.current.failed_registration)) {
        return false;
      } else {
        rethrow;
      }
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<bool> logout() async {
    try {
      String response = await _postRequest(_apiBaseUrl + 'logout', '');
      Map<String, dynamic> data = jsonDecode(response);
      if (data.containsKey('username')) {
        _username = null;
        _isLoggedIn = false;

        // reset header and current raceid
        currentRaceId = 0;
        headers['raceid'] = currentRaceId.toString();
        return true;
      }
      return false;
    } on AuthException catch (_) {
      rethrow;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(
        S.current.unknown_error,
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<bool> setUserDetails(UserDetails user) async {
    try {
      if (user.id <= 0 || user.firstName.isEmpty || user.lastName.isEmpty) {
        throw DataException(S.current.failed_updating_user_invalid_data);
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<int> addUser(UserDetails user) async {
    try {
      if (user.firstName.isEmpty || user.lastName.isEmpty) {
        throw DataException(S.current.failed_updating_user_invalid_data);
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(
        S.current.unknown_error,
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(
        S.current.unknown_error,
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(
        S.current.unknown_error,
        error.toString(),
        error.runtimeType.toString(),
      );
    }
  }

  Future<bool> finishLap(int userId, Time time) async {
    try {
      if (!time.isValid) return false;
      Map<String, dynamic> bodyMap = {'id': userId, 'time': time.isoTime};
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(
        S.current.unknown_error,
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<RankingList> getRankig(String? className) async {
    try {
      String response = '';
      if (className != null && className.isNotEmpty) {
        // escape space to generate api url
        className.replaceAll(' ', '%');
        response = await _getRequest(_apiBaseUrl + 'v1/ranking/' + className);
      } else {
        response = await _getRequest(_apiBaseUrl + 'v1/ranking/all');
      }
      List<dynamic> ranks = jsonDecode(response);
      return RankingList.fromJson(ranks);
    } on AuthException catch (_) {
      rethrow;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<List<Race>> getRaces() async {
    try {
      String response = '';
      response = await _getRequest(_apiBaseUrl + 'v1/races/');

      final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
      return parsed.map<Race>((json) => Race.fromJson(json)).toList();
    } on AuthException catch (_) {
      rethrow;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<int> addRace(String name) async {
    try {
      if (name.isEmpty) {
        throw DataException(S.current.add_race_failed_invalid_input_data);
      }
      Map<String, String> bodyMap = {'name': name};
      String body = jsonEncode(bodyMap);
      String response = await _postRequest(_apiBaseUrl + 'v1/race/', body);
      Map<String, dynamic> map = jsonDecode(response);
      if (map.keys.contains('race_id') && map['race_id'] > 0) {
        return map['race_id'];
      }
      return 0;
    } on AuthException catch (_) {
      rethrow;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<bool> deleteRace(int raceID) async {
    try {
      Map<String, int> bodyMap = {'id': raceID};
      String body = jsonEncode(bodyMap);
      String response = await _deleteRequest(_apiBaseUrl + 'v1/race/', body);
      Map<String, dynamic> map = jsonDecode(response);

      if (map.keys.contains('affected_rows') &&
          map['affected_rows'] is int &&
          map['affected_rows'] >= 0) {
        return true;
      } else {
        return false;
      }
    } on AuthException catch (_) {
      rethrow;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(
        S.current.unknown_error,
        error.toString(),
        error.runtimeType.toString(),
      );
    }
  }

  Future<RaceDetails> getRaceDetails(int raceId) async {
    try {
      String response = '';
      response =
          await _getRequest(_apiBaseUrl + 'v1/race/' + raceId.toString());
      return RaceDetails.fromJson(jsonDecode(response));
    } on AuthException catch (_) {
      rethrow;
    } on RacegoException catch (_) {
      rethrow;
    } on TypeError catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
    }
  }

  Future<bool> setRaceDetails(RaceDetails raceDetails) async {
    try {
      if (raceDetails.id <= 0 ||
          raceDetails.name.isEmpty ||
          raceDetails.managers.isEmpty) {
        throw DataException(S.current.failed_updating_user_invalid_data);
      }

      String response = await _postRequest(
          _apiBaseUrl + 'v1/race/' + raceDetails.id.toString(),
          jsonEncode(raceDetails.toJson()));
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
      throw DataException(S.current.failed_parsing_response);
    } on FormatException catch (_) {
      throw DataException(S.current.failed_parsing_response);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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
          // reset header and current raceid
          currentRaceId = 0;
          headers['raceid'] = currentRaceId.toString();
          throw AuthException(S.current.no_permission);
        case 403:
          _isLoggedIn = false;
          _username = null;
          // reset header and current raceid
          currentRaceId = 0;
          headers['raceid'] = currentRaceId.toString();
          throw AuthException(S.current.failed_login);
        case 404:
          throw ServerException(S.current.requestet_entity_not_found);
        case 409:
          throw DataException(S.current.failed_send_conflicting_data);
        case 422:
          throw DataException(S.current.unprocessable_entity);
        default:
          throw ServerException(
              S.current.invalid_server_response(response.statusCode));
      }
    } on RacegoException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      throw InternetException(S.current.failed_server_timeout);
    } on TimeoutException catch (_) {
      throw InternetException(S.current.failed_server_timeout);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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
          // reset header and current raceid
          currentRaceId = 0;
          headers['raceid'] = currentRaceId.toString();
          throw AuthException(S.current.no_permission);
        case 403:
          _isLoggedIn = false;
          _username = null;
          // reset header and current raceid
          currentRaceId = 0;
          headers['raceid'] = currentRaceId.toString();
          throw AuthException(S.current.failed_login);
        case 404:
          throw ServerException(S.current.requestet_entity_not_found);
        case 409:
          throw DataException(S.current.failed_send_conflicting_data);
        case 422:
          throw DataException(S.current.unprocessable_entity);
        default:
          throw ServerException(
              S.current.invalid_server_response(response.statusCode));
      }
    } on RacegoException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      throw InternetException(S.current.failed_server_timeout);
    } on TimeoutException catch (_) {
      throw InternetException(S.current.failed_server_timeout);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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
          // reset header and current raceid
          currentRaceId = 0;
          headers['raceid'] = currentRaceId.toString();
          throw AuthException(S.current.no_permission);
        case 403:
          _isLoggedIn = false;
          _username = null;
          // reset header and current raceid
          currentRaceId = 0;
          headers['raceid'] = currentRaceId.toString();
          throw AuthException(S.current.failed_login);
        case 404:
          throw ServerException(S.current.requestet_entity_not_found);
        case 409:
          throw DataException(S.current.failed_send_conflicting_data);
        case 422:
          throw DataException(S.current.unprocessable_entity);
        default:
          throw ServerException(
              S.current.invalid_server_response(response.statusCode));
      }
    } on RacegoException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      throw InternetException(S.current.failed_server_timeout);
    } on TimeoutException catch (_) {
      throw InternetException(S.current.failed_server_timeout);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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
          // reset header and current raceid
          currentRaceId = 0;
          headers['raceid'] = currentRaceId.toString();
          throw AuthException(S.current.no_permission);
        case 403:
          _isLoggedIn = false;
          _username = null;
          // reset header and current raceid
          currentRaceId = 0;
          headers['raceid'] = currentRaceId.toString();
          throw AuthException(S.current.failed_login);
        case 404:
          throw ServerException(S.current.requestet_entity_not_found);
        case 409:
          throw DataException(S.current.failed_send_conflicting_data);
        case 422:
          throw DataException(S.current.unprocessable_entity);
        default:
          throw ServerException(
              S.current.invalid_server_response(response.statusCode));
      }
    } on RacegoException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      throw InternetException(S.current.failed_server_timeout);
    } on TimeoutException catch (_) {
      throw InternetException(S.current.failed_server_timeout);
    } catch (error) {
      throw UnknownException(S.current.unknown_error, error.toString(),
          error.runtimeType.toString());
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
