import 'package:json_annotation/json_annotation.dart';

part 'exercise_entity.g.dart';

@JsonSerializable()
class ExerciseEntity {
  @JsonKey()
  final String? id;

  @JsonKey(name: 'audio_link')
  final String? audioLink;

  @JsonKey()
  final String? desc;

  @JsonKey(name: 'expert_id')
  final String? expertId;

  @JsonKey(name: 'expert_name')
  final String? expertName;

  @JsonKey(name: 'expert_avatar')
  final String? expertAvatar;

  @JsonKey(name: 'video_link')
  final String? videoLink;

  @JsonKey(name: 'video_type')
  final String? videoType;

  @JsonKey(name: 'video_duration')
  final String? videoDuration;

  @JsonKey(name: 'video_thumbnail')
  final String? videoThumbnail;

  @JsonKey()
  final String? title;

  @JsonKey(name: 'hashtags')
  final List<String?> hashTags;

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
    required this.expertName,
    required this.videoDuration,
    required this.hashTags,
    required this.videoLink,
    required this.videoThumbnail,
    required this.createdAt,
    required this.updatedAt,
    required this.videoType,
  });

  ExerciseEntity copyWith({
    String? id,
    String? title,
    String? desc,
    String? audioLink,
    String? expertId,
    String? expertAvatar,
    String? expertName,
    String? videoDuration,
    String? videoLink,
    String? videoThumbnail,
    String? videoType,
    List<String>? hashTags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExerciseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      audioLink: audioLink ?? this.audioLink,
      expertId: expertId ?? this.expertId,
      expertAvatar: expertAvatar ?? this.expertAvatar,
      expertName: expertName ?? this.expertName,
      videoDuration: videoDuration ?? this.videoDuration,
      videoLink: videoLink ?? this.videoLink,
      videoType: videoType ?? this.videoType,
      hashTags: hashTags ?? this.hashTags,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ExerciseEntity.fromJson(Map<String, dynamic> json) =>
      _$ExerciseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseEntityToJson(this);
}
