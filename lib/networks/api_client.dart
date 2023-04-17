import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  ///Remote setting
  // @GET("/api/remove-setting")
  // Future<RemoteSettingEntity> getRemoteSetting();
  //
  // ///Authenticate - UserInfo
  // @POST("/msx-sts/api/domain/v1/auth/mobile/bql/login")
  // Future<TokenEntity> authLogin(@Body() Map<String, dynamic> body);
  //
  // @GET("/msx-employee/api/query/v1/employee/getProfile")
  // Future<UserEntity> getUser();

}
