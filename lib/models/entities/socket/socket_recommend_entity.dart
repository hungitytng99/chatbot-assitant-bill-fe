import 'package:json_annotation/json_annotation.dart';
part 'socket_recommend_entity.g.dart';

@JsonSerializable()
class SocketRecommendEntity {
  @JsonKey()
  final List<String>? objectives;

  SocketRecommendEntity({
    required this.objectives,
  });

  SocketRecommendEntity copyWith({
    String? question,
    List<String>? objectives,
  }) {
    return SocketRecommendEntity(
      objectives: objectives ?? this.objectives,
    );
  }

  factory SocketRecommendEntity.fromJson(Map<String, dynamic> json) =>
      _$SocketRecommendEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SocketRecommendEntityToJson(this);
}
