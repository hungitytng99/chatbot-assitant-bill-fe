import 'package:json_annotation/json_annotation.dart';

part 'sign_up_body.g.dart';

@JsonSerializable()
class SignUpBody {
  @JsonKey(name: 'fullname')
  String? fullName;

  @JsonKey()
  String? username;

  @JsonKey()
  String? password;

  SignUpBody({this.fullName, this.username, this.password});

  factory SignUpBody.fromEmail(
      String username, String fullName, String password) {
    return SignUpBody(fullName: fullName, username: username, password: password);
  }

  factory SignUpBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBodyToJson(this);
}
