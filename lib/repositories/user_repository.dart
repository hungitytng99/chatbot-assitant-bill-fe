import 'dart:io';
import 'package:ihz_bql/networks/api_client.dart';

abstract class UserRepository {


  Future updateProfile(Map<String, dynamic> body);

}

class UserRepositoryImpl extends UserRepository {
  late ApiClient _apiClient;

  UserRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future updateProfile(Map<String, dynamic> body) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

}
