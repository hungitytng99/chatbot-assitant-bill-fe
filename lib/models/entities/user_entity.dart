import 'package:json_annotation/json_annotation.dart';
part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey()
  final String id;

  @JsonKey()
  final String? email;

  @JsonKey()
  final String role;

  @JsonKey()
  final String? username;

  @JsonKey(name: 'fullname')
  final String? fullName;

  UserEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.username,
    required this.fullName,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? role,
    String? username,
    String? fullName,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
