

import 'package:ihz_bql/models/entities/conversation_detail_entity.dart';
import 'package:ihz_bql/models/entities/conversation_detail_entity.dart';
import 'package:ihz_bql/models/entities/conversation_history_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation_response_entity.g.dart';

@JsonSerializable()
class ConversationResponseEntity {
  @JsonKey()
  final ConversationDetailEntity conversation;

  ConversationResponseEntity({
    required this.conversation,
  });

  ConversationResponseEntity copyWith({
    ConversationDetailEntity? conversation,
  }) {
    return ConversationResponseEntity(
      conversation: conversation ?? this.conversation,
    );
  }

  factory ConversationResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationResponseEntityToJson(this);
}
