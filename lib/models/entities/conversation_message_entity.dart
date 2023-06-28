import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation_message_entity.g.dart';

@JsonSerializable()
class ConversationMessageEntity {
  @JsonKey()
  final String id;
  @JsonKey(name: "message")
  final String? content;
  @JsonKey()
  final String type;
  @JsonKey()
  final String? question;
  @JsonKey()
  final List<String>? answers;
  @JsonKey()
  final String? actor;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  ConversationMessageEntity({
    required this.id,
    required this.actor,
    required this.type,
    this.content,
    this.updatedAt,
    this.createdAt,
    this.question,
    this.answers,
  });

  ConversationMessageEntity copyWith({
    String? id,
    String? content,
    String? type,
    String? actor,
    String? question,
    List<String>? answers,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return ConversationMessageEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      actor: actor ?? this.actor,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ConversationMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationMessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationMessageEntityToJson(this);
}
