import 'package:json_annotation/json_annotation.dart';
part 'socket_text_entity.g.dart';

@JsonSerializable()
class SocketTextEntity {
  @JsonKey()
  final String message;

  SocketTextEntity({
    required this.message,
  });

  SocketTextEntity copyWith({
    String? message,
  }) {
    return SocketTextEntity(
      message: message ?? this.message,
    );
  }

  factory SocketTextEntity.fromJson(Map<String, dynamic> json) =>
      _$SocketTextEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SocketTextEntityToJson(this);
}
