import 'package:json_annotation/json_annotation.dart';

part 'feedback_exercise_body.g.dart';

@JsonSerializable()
class FeedbackExerciseBody {
  @JsonKey(name: 'practice_id')
  String practiceId;

  @JsonKey(name: 'exercise_name')
  String exerciseName;

  @JsonKey(name: 'exercise_id')
  String exerciseId;

  @JsonKey(name: 'mind_rate')
  String mindRate;

  @JsonKey(name: 'body_rate')
  String bodyRate;

  @JsonKey(name: 'exercise_rate')
  String exerciseRate;

  @JsonKey(name: 'keyword_desc')
  List<String> keywordDesc;

  FeedbackExerciseBody({
    required this.practiceId,
    required this.exerciseName,
    required this.exerciseId,
    required this.mindRate,
    required this.bodyRate,
    required this.exerciseRate,
    required this.keywordDesc,
  });

  factory FeedbackExerciseBody.fromJson(Map<String, dynamic> json) =>
      _$FeedbackExerciseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackExerciseBodyToJson(this);
}
