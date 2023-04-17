// import 'package:ihz_bql/models/entities/user/permission_entity.dart';
// import 'package:ihz_bql/models/entities/user/role_entity.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'employee_infor_entity.dart';
//
// part 'user_role_entity.g.dart';
//
// @JsonSerializable()
// class UserRoleEntity {
//   @JsonKey(name: "_id")
//   String? idPrivate;
//   @JsonKey()
//   List<PermissionEntity>? permissions;
//   @JsonKey()
//   List<String>? deviceTokens;
//   @JsonKey()
//   bool? isFirstLogin;
//   @JsonKey()
//   String? description;
//   @JsonKey()
//   bool? active;
//   @JsonKey()
//   bool? softDelete;
//   @JsonKey()
//   dynamic? modifiedBy;
//   @JsonKey()
//   dynamic? registerStatus;
//   @JsonKey()
//   bool? authOtp;
//   @JsonKey()
//   bool? isAdmin;
//   @JsonKey()
//   List<dynamic>? roleCanAssign;
//   @JsonKey()
//   String? name;
//   @JsonKey()
//   String? email;
//   @JsonKey()
//   String? status;
//   @JsonKey()
//   String? phone;
//   @JsonKey()
//   String? roleId;
//   @JsonKey()
//   String? system;
//   @JsonKey()
//   dynamic? workingAt;
//   @JsonKey()
//   dynamic? managerAt;
//   @JsonKey(name: "id")
//   String? id;
//   @JsonKey()
//   String? codeDx;
//   @JsonKey(name: "__v")
//   int? v;
//   @JsonKey()
//   EmployeeInfoEntity? employeeInfo;
//   @JsonKey()
//   List<RoleEntity>? role;
//   @JsonKey()
//   String? otp;
//
//   bool isContainPermission(String permission) {
//     if (permissions?.isEmpty == true || permissions == null) {
//       return false;
//     }
//     try {
//       final perItem = permissions?.firstWhere((element) {
//         return element.featureName == permission;
//       });
//       return perItem?.action?.readOwn == true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   bool isContainMSX(String msx) {
//     if (permissions?.isEmpty == true || permissions == null) {
//       return false;
//     }
//     try {
//       final perItem = permissions?.firstWhere((element) {
//         return element.msxName == msx;
//       });
//       return perItem?.action?.readOwn == true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   UserRoleEntity({
//     this.idPrivate,
//     this.permissions,
//     this.isFirstLogin,
//     this.description,
//     this.active,
//     this.softDelete,
//     this.modifiedBy,
//     this.registerStatus,
//     this.authOtp,
//     this.name,
//     this.email,
//     this.status,
//     this.phone,
//     this.roleId,
//     this.workingAt,
//     this.managerAt,
//     this.id,
//     this.codeDx,
//     this.v,
//     this.employeeInfo,
//     this.role,
//     this.otp,
//     this.deviceTokens,
//     this.isAdmin,
//     this.roleCanAssign,
//     this.system,
//   });
//
//   factory UserRoleEntity.fromJson(Map<String, dynamic> json) => _$UserRoleEntityFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserRoleEntityToJson(this);
// }
