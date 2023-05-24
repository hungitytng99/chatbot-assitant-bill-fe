import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exercise_filter_entity.g.dart';

@JsonSerializable()
class ExerciseFilterEntity {
  @JsonKey()
  final List<ExerciseEntity> exercises;

  ExerciseFilterEntity({
    required this.exercises,
  });

  ExerciseFilterEntity copyWith({
    List<ExerciseEntity>? exercises,
  }) {
    return ExerciseFilterEntity(
      exercises: exercises ?? this.exercises,
    );
  }

  factory ExerciseFilterEntity.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFilterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseFilterEntityToJson(this);
}
