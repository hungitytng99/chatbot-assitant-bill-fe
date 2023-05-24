import 'package:json_annotation/json_annotation.dart';

part 'exercise_filter_params.g.dart';

@JsonSerializable()
class ForgotPasswordParam {
  @JsonKey(name: 'expert_id')
  String? expertId;

  @JsonKey()
  String? query;

  @JsonKey()
  String? hashtag;

  @JsonKey()
  int? page;

  @JsonKey()
  int? limit;

  ForgotPasswordParam({
    this.expertId,
    this.query,
    this.hashtag,
    this.page = 1,
    this.limit = 10,
  });

  factory ForgotPasswordParam.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordParamFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordParamToJson(this);
}
