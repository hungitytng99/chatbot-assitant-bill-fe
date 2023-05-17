import 'package:ihz_bql/models/entities/objective_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expert_entity.g.dart';

@JsonSerializable()
class ExpertEntity {
  @JsonKey()
  final String id;
  @JsonKey()
  final String alias;
  @JsonKey()
  final String name;
  @JsonKey(name: 'avatar_link')
  final String avatarLink;
  @JsonKey()
  final String desc;
  @JsonKey()
  final List<ObjectiveEntity> objectives;

  ExpertEntity({
    required this.id,
    required this.desc,
    required this.avatarLink,
    required this.alias,
    required this.objectives,
    required this.name,
  });

  ExpertEntity copyWith({
    String? id,
    String? desc,
    String? avatarLink,
    String? alias,
    String? name,
    List<ObjectiveEntity>? objectives,
  }) {
    return ExpertEntity(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      name: name ?? this.name,
      avatarLink: avatarLink ?? this.avatarLink,
      alias: alias ?? this.alias,
      objectives: objectives ?? this.objectives,
    );
  }

  factory ExpertEntity.fromJson(Map<String, dynamic> json) =>
      _$ExpertEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ExpertEntityToJson(this);
}
