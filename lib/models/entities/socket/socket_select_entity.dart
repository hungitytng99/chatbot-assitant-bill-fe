import 'package:json_annotation/json_annotation.dart';
part 'socket_select_entity.g.dart';

@JsonSerializable()
class SocketSelectEntity {
  @JsonKey()
  final String question;
  @JsonKey()
  final List<String>? answers;

  SocketSelectEntity({
    required this.question,
    required this.answers,
  });

  SocketSelectEntity copyWith({
    String? question,
    List<String>? answers,
  }) {
    return SocketSelectEntity(
      question: question ?? this.question,
      answers: answers ?? this.answers,
    );
  }

  factory SocketSelectEntity.fromJson(Map<String, dynamic> json) =>
      _$SocketSelectEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SocketSelectEntityToJson(this);
}
