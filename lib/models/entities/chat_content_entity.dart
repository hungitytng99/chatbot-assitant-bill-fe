import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChatContentEntity {
  final int id;
  final String chatContent;
  final bool isOwner;

  ChatContentEntity({
    required this.id,
    required this.chatContent,
    required this.isOwner,
  });

  factory ChatContentEntity.fromJson(Map<String, dynamic> json) =>
      ChatContentEntity(
        id: json['char_id'],
        chatContent: json['name'],
        isOwner: json['isOwner'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatContent": chatContent,
        "isOwner": isOwner,
      };
}
