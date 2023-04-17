import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_param.g.dart';

@JsonSerializable()
class ForgotPasswordParam{
  @JsonKey()
  String? username;

  ForgotPasswordParam({this.username});

  factory ForgotPasswordParam.fromEmail(String email){
    return ForgotPasswordParam(
      username: email,
    );
  }

  factory ForgotPasswordParam.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordParamFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordParamToJson(this);
}