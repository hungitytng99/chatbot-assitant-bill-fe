import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TokenEntity {
  String? expiresIn;
  String? accessToken;
  String? id;
  bool? isFirstLogin;
  String? roleId;
  String? codeDx;

  TokenEntity({
    this.expiresIn,
    this.accessToken,
    this.id,
    this.isFirstLogin,
    this.roleId,
    this.codeDx,
  });

  factory TokenEntity.fromJson(Map<String, dynamic> json) => TokenEntity(
    expiresIn: json["expires_in"],
    accessToken: json["access_token"],
    id: json["id"],
    isFirstLogin: json["isFirstLogin"],
    roleId: json["roleId"],
    codeDx: json["codeDX"],
  );

  Map<String, dynamic> toJson() => {
    "expires_in": expiresIn,
    "access_token": accessToken,
    "id": id,
    "isFirstLogin": isFirstLogin,
    "roleId": roleId,
    "codeDX": codeDx,
  };
}
