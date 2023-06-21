import 'dart:ffi';

import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation_message_entity.g.dart';

@JsonSerializable()
class ConversationMessageEntity {
  @JsonKey()
  final String id;
  @JsonKey()
  final String? content;
  @JsonKey()
  final String? actor;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  ConversationMessageEntity({
    required this.id,
    required this.content,
    required this.actor,
    required this.updatedAt,
    required this.createdAt,
  });

  ConversationMessageEntity copyWith(
      {String? id,
      String? content,
      String? actor,
      DateTime? updatedAt,
      DateTime? createdAt}) {
    return ConversationMessageEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      actor: actor ?? this.actor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ConversationMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationMessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationMessageEntityToJson(this);
}
