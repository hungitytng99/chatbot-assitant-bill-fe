import 'package:ihz_bql/models/entities/user_entity.dart';
import 'package:ihz_bql/networks/api_client.dart';

abstract class UserRepository {
  Future updateProfile(Map<String, dynamic> body);
  Future<UserEntity> getMyProfile();

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

  @override
  Future<UserEntity> getMyProfile() {
    return _apiClient.getMyProfile();
  }

}
