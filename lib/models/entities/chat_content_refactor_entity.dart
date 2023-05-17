import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChatContentRefactorEntity {
  final int id;
  final List<String> chatContent;
  final bool isOwner;
  final String type;

  ChatContentRefactorEntity({
    required this.id,
    required this.chatContent,
    required this.isOwner,
    required this.type,
  });

  factory ChatContentRefactorEntity.fromJson(Map<String, dynamic> json) =>
      ChatContentRefactorEntity(
        id: json['char_id'],
        chatContent: json['name'],
        isOwner: json['isOwner'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatContent": chatContent,
        "isOwner": isOwner,
        "type": type,
      };
}
