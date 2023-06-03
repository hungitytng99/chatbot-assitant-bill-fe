import 'package:json_annotation/json_annotation.dart';
part 'end_practice_response_entity.g.dart';

@JsonSerializable()
class EndPracticeResponseEntity {
  @JsonKey()
  final String id;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'exercise_id')
  final String exerciseId;

  @JsonKey()
  final String? username;

  @JsonKey(name: 'user_fullname')
  final String? fullName;

  @JsonKey(name: 'exercise_name')
  final String? exerciseName;

  @JsonKey(name: 'practice_duration')
  final String? practiceDuration;

  @JsonKey(name: 'action_type')
  final String? actionType;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'started_at')
  final DateTime? startedAt;

  @JsonKey(name: 'ended_at')
  final DateTime? endedAt;

  EndPracticeResponseEntity({
    required this.id,
    required this.username,
    required this.fullName,
    required this.actionType,
    required this.createdAt,
    required this.endedAt,
    required this.exerciseId,
    required this.exerciseName,
    required this.practiceDuration,
    required this.startedAt,
    required this.updatedAt,
    required this.userId,
  });

  EndPracticeResponseEntity copyWith({
    String? id,
    String? actionType,
    String? username,
    String? fullName,
    String? exerciseId,
    String? exerciseName,
    String? practiceDuration,
    String? userId,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? updatedAt,
    DateTime? endedAt,
  }) {
    return EndPracticeResponseEntity(
      id: id ?? this.id,
      actionType: actionType ?? this.actionType,
      endedAt: endedAt ?? this.endedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      startedAt: startedAt ?? this.startedAt,
      createdAt: createdAt ?? this.createdAt,
      username: username ?? this.username,
      userId: userId ?? this.userId,
      practiceDuration: practiceDuration ?? this.practiceDuration,
      exerciseName: exerciseName ?? this.exerciseName,
      exerciseId: exerciseId ?? this.exerciseId,
      fullName: fullName ?? this.fullName,
    );
  }

  factory EndPracticeResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$EndPracticeResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EndPracticeResponseEntityToJson(this);
}
