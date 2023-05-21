import 'package:json_annotation/json_annotation.dart';
part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey()
  final String id;

  @JsonKey()
  final String email;

  @JsonKey()
  final String role;

  UserEntity({
    required this.id,
    required this.email,
    required this.role,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
