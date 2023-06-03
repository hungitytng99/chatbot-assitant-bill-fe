import 'package:json_annotation/json_annotation.dart';

part 'end_exercise_body.g.dart';

@JsonSerializable()
class EndExerciseBody {
  @JsonKey(name: 'exercise_id')
  String exerciseId;

  @JsonKey(name: 'exercise_name')
  String exerciseName;

  @JsonKey(name: 'practice_duration')
  String practiceDuration;

  @JsonKey(name: 'started_at')
  DateTime startedAt;

  @JsonKey(name: 'ended_at')
  DateTime endedAt;

  EndExerciseBody({
    required this.exerciseId,
    required this.exerciseName,
    required this.practiceDuration,
    required this.startedAt,
    required this.endedAt,
  });

  factory EndExerciseBody.fromEmail(
    String exerciseId,
    String exerciseName,
    String practiceDuration,
    DateTime startedAt,
    DateTime endedAt,
  ) {
    return EndExerciseBody(
      exerciseId: exerciseId,
      exerciseName: exerciseName,
      practiceDuration: practiceDuration,
      startedAt: startedAt,
      endedAt: endedAt,
    );
  }

  factory EndExerciseBody.fromJson(Map<String, dynamic> json) =>
      _$EndExerciseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EndExerciseBodyToJson(this);
}
