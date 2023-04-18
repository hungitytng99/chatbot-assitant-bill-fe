import 'dart:io';
import 'package:ihz_bql/networks/api_client.dart';

abstract class AuthRepository {
  Future updateProfile(Map<String, dynamic> body);


}

class AuthRepositoryImpl extends AuthRepository {
  late ApiClient _apiClient;

  AuthRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future updateProfile(Map<String, dynamic> body) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

}
