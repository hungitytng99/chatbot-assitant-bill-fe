

import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'daily_actions_entity.g.dart';

@JsonSerializable()
class DailyActionEntity {
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

  @JsonKey(name: 'body_rate')
  final String? bodyRate;

  @JsonKey(name: 'mind_rate')
  final String? mindRate;

  @JsonKey(name: 'exercise_rate')
  final String? exerciseRate;

  @JsonKey(name: 'keyword_desc')
  final List<String>? keywordDesc;

  @JsonKey(name: 'is_feedbacked')
  final bool? isFeedback;

  @JsonKey()
  final String? note;

  DailyActionEntity({
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
    required this.bodyRate,
    required this.keywordDesc,
    required this.exerciseRate,
    required this.mindRate,
    required this.note,
    this.isFeedback = false,
  });

  DailyActionEntity copyWith({
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
    String? bodyRate,
    List<String>? keywordDesc,
    String? exerciseRate,
    String? mindRate,
    String? note,
    bool? isFeedback,
  }) {
    return DailyActionEntity(
      id: id ?? this.id,
      note: note ?? this.note,
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
      bodyRate: bodyRate ?? this.bodyRate,
      keywordDesc: keywordDesc ?? this.keywordDesc,
      exerciseRate: exerciseRate ?? this.exerciseRate,
      mindRate: mindRate ?? this.mindRate,
      isFeedback: isFeedback ?? this.isFeedback,
    );
  }

  factory DailyActionEntity.fromJson(Map<String, dynamic> json) =>
      _$DailyActionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DailyActionEntityToJson(this);
}
