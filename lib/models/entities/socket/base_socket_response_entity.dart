import 'package:json_annotation/json_annotation.dart';
part 'base_socket_response_entity.g.dart';

@JsonSerializable()
class BaseSocketResponseEntity {
  @JsonKey()
  final String event;
  @JsonKey()
  final String? type;
  @JsonKey(name: 'message_id')
  final String? messageId;
  @JsonKey(name: 'connection_id')
  final String? connectionId;

  BaseSocketResponseEntity({
    required this.event,
    required this.type,
    required this.messageId,
    required this.connectionId,
  });

  BaseSocketResponseEntity copyWith({
    String? event,
    String? type,
    String? messageId,
    String? connectionId,
  }) {
    return BaseSocketResponseEntity(
      event: event ?? this.event,
      type: type ?? this.type,
      messageId: messageId ?? this.messageId,
      connectionId: connectionId ?? this.connectionId,
    );
  }

  factory BaseSocketResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseSocketResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseSocketResponseEntityToJson(this);
}
