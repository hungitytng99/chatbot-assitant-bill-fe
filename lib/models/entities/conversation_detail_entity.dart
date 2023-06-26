

import 'package:ihz_bql/models/entities/conversation_message_entity.dart';
import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation_detail_entity.g.dart';

@JsonSerializable()
class ConversationDetailEntity {
  @JsonKey()
  final String id;
  @JsonKey()
  final String? title;
  @JsonKey()
  final List<ConversationMessageEntity>? messages;

  ConversationDetailEntity({
    required this.id,
    required this.title,
    required this.messages,
  });

  ConversationDetailEntity copyWith({
    String? id,
    String? title,
    List<ConversationMessageEntity>? messages,
  }) {
    return ConversationDetailEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      messages: messages ?? this.messages,
    );
  }

  factory ConversationDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationDetailEntityToJson(this);
}
