import 'package:json_annotation/json_annotation.dart';

part 'sign_in_body.g.dart';

@JsonSerializable()
class SignInBody {
  @JsonKey()
  String username;

  @JsonKey()
  String password;

  SignInBody({required this.username, required this.password});

  factory SignInBody.fromEmail(String username, String password) {
    return SignInBody(username: username, password: password);
  }

  factory SignInBody.fromJson(Map<String, dynamic> json) =>
      _$SignInBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignInBodyToJson(this);
}
