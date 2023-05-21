import 'package:json_annotation/json_annotation.dart';

part 'exercise_entity.g.dart';

@JsonSerializable()
class ExerciseEntity {
  @JsonKey()
  final String id;
  @JsonKey(name: 'audio_link')
  final String audioLink;
  @JsonKey()
  final String desc;
  @JsonKey(name: 'expert_id')
  final String expertId;
  @JsonKey(name: 'expert_avatar')
  final String? expertAvatar;
  @JsonKey(name: 'video_link')
  final String videoLink;
  @JsonKey()
  final String thumbnail;
  @JsonKey()
  final String title;
  @JsonKey(name: 'hash_tag')
  final List<String> hashTag;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  ExerciseEntity({
    required this.id,
    required this.title,
    required this.desc,
    required this.audioLink,
    required this.expertId,
    required this.expertAvatar,
    required this.hashTag,
    required this.videoLink,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
  });

  ExerciseEntity copyWith({
    String? id,
    String? title,
    String? desc,
    String? audioLink,
    String? expertId,
    String? expertAvatar,
    String? videoLink,
    String? thumbnail,
    List<String>? hashTag,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExerciseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      audioLink: audioLink ?? this.audioLink,
      expertId: expertId ?? this.expertId,
      videoLink: videoLink ?? this.videoLink,
      expertAvatar: expertAvatar ?? this.expertAvatar,
      hashTag: hashTag ?? this.hashTag,
      thumbnail: thumbnail ?? this.thumbnail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ExerciseEntity.fromJson(Map<String, dynamic> json) =>
      _$ExerciseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseEntityToJson(this);
}
