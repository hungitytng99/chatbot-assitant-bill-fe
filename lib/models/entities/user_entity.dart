import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserEntity {
  final int id;
  final String email;
  final String role;

  UserEntity({
    required this.id,
    required this.email,
    required this.role,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      UserEntity(
        id: json['id'],
        email: json['email'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "role": role,
      };
}
