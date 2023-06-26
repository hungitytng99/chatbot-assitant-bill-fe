

import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create_conversation_entity.g.dart';

@JsonSerializable()
class CreateConversationEntity {
  @JsonKey()
  final String id;
  @JsonKey(name: 'connection_id')
  final String? connectionId;
  @JsonKey(name: 'expert_id')
  final String? expertId;

  @JsonKey()
  final String? title;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey()
  final String? status;

  @JsonKey(name: 'socket_path')
  final String? socketPath;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  CreateConversationEntity({
    required this.id,
    required this.connectionId,
    required this.expertId,
    required this.updatedAt,
    required this.createdAt,
    required this.title,
    required this.status,
    required this.userId,
    required this.socketPath,
  });

  CreateConversationEntity copyWith(
      {String? id,
      String? connectionId,
      String? expertId,
      String? title,
      String? status,
      String? userId,
      String? socketPath,
      DateTime? updatedAt,
      DateTime? createdAt}) {
    return CreateConversationEntity(
      id: id ?? this.id,
      connectionId: connectionId ?? this.connectionId,
      expertId: expertId ?? this.expertId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      socketPath: socketPath ?? this.socketPath,
    );
  }

  factory CreateConversationEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateConversationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateConversationEntityToJson(this);
}
