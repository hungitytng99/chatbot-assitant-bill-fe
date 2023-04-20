import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChatContentEntity {
  final int id;
  final String chatContent;

  ChatContentEntity({
    required this.id,
    required this.chatContent,
  });

  factory ChatContentEntity.fromJson(Map<String, dynamic> json) => ChatContentEntity(
        id: json['char_id'],
        chatContent: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatContent": chatContent,
      };
}
