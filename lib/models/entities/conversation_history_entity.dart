import 'dart:ffi';

import 'package:ihz_bql/models/entities/conversation_history_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation_history_entity.g.dart';
@JsonSerializable()
class ConversationHistoryEntity {
  @JsonKey()
  final List<ConversationHistoryItemEntity> conversations;

  ConversationHistoryEntity({
    required this.conversations,
  });

  ConversationHistoryEntity copyWith({
    List<ConversationHistoryItemEntity>? conversations,
  }) {
    return ConversationHistoryEntity(
      conversations: conversations ?? this.conversations,
    );
  }

  factory ConversationHistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationHistoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationHistoryEntityToJson(this);
}
