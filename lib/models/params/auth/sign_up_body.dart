import 'package:json_annotation/json_annotation.dart';

part 'sign_up_body.g.dart';

@JsonSerializable()
class SignUpBody {
  @JsonKey()
  String? fullName;

  @JsonKey()
  String? email;

  @JsonKey()
  String? password;

  SignUpBody({this.fullName, this.email, this.password});

  factory SignUpBody.fromEmail(
      String email, String fullName, String password) {
    return SignUpBody(fullName: fullName, email: email, password: password);
  }

  factory SignUpBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBodyToJson(this);
}
