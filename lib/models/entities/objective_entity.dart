import 'package:json_annotation/json_annotation.dart';
part 'objective_entity.g.dart';

@JsonSerializable()
class ObjectiveEntity {
  @JsonKey()
  final String id;
  @JsonKey()
  final String title;
  @JsonKey()
  final String definition;

  ObjectiveEntity({
    required this.id,
    required this.title,
    required this.definition,
  });

  ObjectiveEntity copyWith({
    String? id,
    String? title,
    String? definition,
  }) {
    return ObjectiveEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      definition: definition ?? this.definition,
    );
  }

  factory ObjectiveEntity.fromJson(Map<String, dynamic> json) =>
      _$ObjectiveEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectiveEntityToJson(this);
}
