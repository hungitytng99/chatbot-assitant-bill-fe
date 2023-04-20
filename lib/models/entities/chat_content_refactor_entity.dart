import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChatContentRefactorEntity {
  final int id;
  final List<String> chatContent;
  final bool isOwner;

  ChatContentRefactorEntity({
    required this.id,
    required this.chatContent,
    required this.isOwner,
  });

  factory ChatContentRefactorEntity.fromJson(Map<String, dynamic> json) =>
      ChatContentRefactorEntity(
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
