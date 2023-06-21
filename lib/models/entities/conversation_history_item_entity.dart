import 'dart:ffi';

import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation_history_item_entity.g.dart';

@JsonSerializable()
class ConversationHistoryItemEntity {
  @JsonKey()
  final String id;

  @JsonKey(name: 'connection_id')
  final String? connectionId;

  @JsonKey()
  final String status;

  @JsonKey(name: "last_message")
  final String lastMessage;

  @JsonKey()
  final ExpertEntity? expert;

  @JsonKey(name: 'expert_id')
  final String? expertId;

  @JsonKey()
  final String? title;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  ConversationHistoryItemEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.expertId,
    required this.status,
    required this.connectionId,
    required this.expert,
    required this.lastMessage,
  });

  ConversationHistoryItemEntity copyWith({
    String? id,
    String? connectionId,
    String? expertId,
    String? title,
    String? lastMessage,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    ExpertEntity? expert,
  }) {
    return ConversationHistoryItemEntity(
      id: id ?? this.id,
      connectionId: connectionId ?? this.connectionId,
      expertId: expertId ?? this.expertId,
      title: title ?? this.title,
      lastMessage: lastMessage ?? this.lastMessage,
      expert: expert ?? this.expert,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ConversationHistoryItemEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationHistoryItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationHistoryItemEntityToJson(this);
}
