import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ihz_bql/models/entities/auth_token_entity.dart';

import 'share_preferences_helper.dart';

class SecureStorageHelper {
  static const _apiTokenKey = '_apiTokenKey';

  final FlutterSecureStorage _storage;

  SecureStorageHelper._internal(this._storage);

  static final SecureStorageHelper _singleton =
      SecureStorageHelper._internal(const FlutterSecureStorage());

  factory SecureStorageHelper() {
    return _singleton;
  }

  factory SecureStorageHelper.getInstance() {
    return _singleton;
  }

  //Save token
  Future<void> saveToken(AuthTokenEntity token) async {
    await _storage.write(key: _apiTokenKey, value: jsonEncode(token.toJson()));
    SharedPreferencesHelper.setApiTokenKey(_apiTokenKey);
  }

  //Remove token
  Future<void> removeToken() async {
    await _storage.delete(key: _apiTokenKey);
    SharedPreferencesHelper.removeApiTokenKey();
  }

  //Get token
  Future<AuthTokenEntity?> getToken() async {
    try {
      final key = await SharedPreferencesHelper.getApiTokenKey();
      final tokenEncoded = await _storage.read(key: key);
      if (tokenEncoded == null) {
        return null;
      } else {
        return AuthTokenEntity.fromJson(
            jsonDecode(tokenEncoded) as Map<String, dynamic>);
      }
    } catch (e) {
      return null;
    }
  }
}
