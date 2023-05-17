import 'package:ihz_bql/models/entities/auth_token_entity.dart';
import 'package:ihz_bql/models/params/auth/sign_in_body.dart';
import 'package:ihz_bql/networks/api_client.dart';

abstract class AuthRepository {
  Future signIn(SignInBody body);
}

class AuthRepositoryImpl extends AuthRepository {
  late ApiClient _apiClient;

  AuthRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<AuthTokenEntity> signIn(SignInBody body) {
    return _apiClient.signIn(body.username, body.password);
  }
}
