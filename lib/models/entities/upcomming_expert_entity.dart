import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/models/entities/objective_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upcomming_expert_entity.g.dart';

@JsonSerializable()
class UpCommingExpertEntity {
  @JsonKey(name: "upcoming_experts")
  final List<ExpertEntity> upCommingExperts;

  UpCommingExpertEntity({
    required this.upCommingExperts,
  });

  UpCommingExpertEntity copyWith({
    List<ExpertEntity>? upCommingExperts,
  }) {
    return UpCommingExpertEntity(
      upCommingExperts: upCommingExperts ?? this.upCommingExperts,
    );
  }

  factory UpCommingExpertEntity.fromJson(Map<String, dynamic> json) =>
      _$UpCommingExpertEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpCommingExpertEntityToJson(this);
}
