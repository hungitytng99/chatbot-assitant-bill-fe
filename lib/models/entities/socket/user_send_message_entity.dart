import 'package:ihz_bql/models/enums/chat_event_name.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_send_message_entity.g.dart';

@JsonSerializable()
class UserSendMessageEntity {
  @JsonKey()
  final String? event;
  @JsonKey()
  final String? message;
  @JsonKey()
  final List<String>? objectives;

  UserSendMessageEntity({
    this.objectives = const [],
    required this.event,
    this.message,
  });

  UserSendMessageEntity copyWith({
    String? event,
    String? message,
    List<String>? objectives,
  }) {
    return UserSendMessageEntity(
      event: event ?? this.event,
      message: message ?? this.message,
      objectives: objectives ?? this.objectives,
    );
  }

  factory UserSendMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$UserSendMessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserSendMessageEntityToJson(this);
}
