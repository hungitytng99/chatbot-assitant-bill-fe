import 'package:json_annotation/json_annotation.dart';

part 'create_conversation_body.g.dart';

@JsonSerializable()
class CreateConversationBody {
  @JsonKey(name: 'expert_id')
  String expertId;

  CreateConversationBody({
    required this.expertId,
  });

  factory CreateConversationBody.fromEmail(
    String expertId,
  ) {
    return CreateConversationBody(
      expertId: expertId,
    );
  }

  factory CreateConversationBody.fromJson(Map<String, dynamic> json) =>
      _$CreateConversationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateConversationBodyToJson(this);
}
