import 'package:get_it/get_it.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/api/http_client_default.dart'
    if (dart.library.html) 'package:racego/data/api/http_client_web.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  const storage = FlutterSecureStorage();
  locator.registerSingleton(RacegoApi(client, storage));
}
