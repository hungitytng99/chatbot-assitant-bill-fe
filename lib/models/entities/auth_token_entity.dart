import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthTokenEntity {
  final String accessToken;
  final String tokenType;

  AuthTokenEntity({
    required this.accessToken,
    required this.tokenType,
  });

  factory AuthTokenEntity.fromJson(Map<String, dynamic> json) =>
      AuthTokenEntity(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
