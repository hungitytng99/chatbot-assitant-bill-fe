// import 'package:equatable/equatable.dart';
// import 'package:ihz_bql/models/entities/area_entity.dart';
// import 'package:ihz_bql/models/entities/image_entity.dart';
// import 'package:ihz_bql/models/entities/social_url_entity.dart';
// import 'package:ihz_bql/models/enums/gender_type.dart';
// import 'package:ihz_bql/utils/date_utils.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'user_entity.g.dart';
//
// @JsonSerializable()
// class UserEntity extends Equatable {
//   UserEntity({
//     this.description,
//     this.active,
//     this.modifiedBy,
//     this.workingAt,
//     this.managerAt,
//     this.interestedArea,
//     this.socialUrls,
//     this.createdAt,
//     this.updatedAt,
//     this.staffIds,
//     this.id,
//     this.name,
//     this.code,
//     this.email,
//     this.status,
//     this.images,
//     this.phone,
//     this.attributes,
//     this.meetingEntityId,
//     this.v,
//     this.extPhone,
//     this.point,
//     this.identityCode,
//     this.identityAddress,
//     this.identityDate,
//     this.secondEmail,
//     this.taxId,
//     this.updatedBy,
//     this.codeDx,
//     this.timePullLatest,
//     this.level,
//     this.propertyUnitPullLatest,
//     this.dob,
//     this.gender,
//     this.erp,
//     this.avatar,
//     this.roleId,
//     this.posId,
//     this.isManage,
//     this.relationIinviter,
//   });
//
//   @JsonKey()
//   String? description;
//   @JsonKey()
//   bool? active;
//   @JsonKey()
//   dynamic modifiedBy;
//   @JsonKey()
//   String? workingAt;
//   @JsonKey()
//   String? managerAt;
//   @JsonKey()
//   AreaEntity? interestedArea;
//   @JsonKey()
//   List<SocialUrlEntity>? socialUrls;
//   @JsonKey()
//   String? createdAt;
//   @JsonKey()
//   String? updatedAt;
//   @JsonKey()
//   List<String>? staffIds;
//   @JsonKey()
//   String? id;
//   @JsonKey()
//   String? name;
//   @JsonKey()
//   String? code;
//   @JsonKey()
//   String? email;
//   @JsonKey()
//   String? status;
//   @JsonKey()
//   ImageEntity? images;
//   @JsonKey()
//   String? phone;
//   @JsonKey()
//   List<dynamic>? attributes;
//   @JsonKey()
//   String? meetingEntityId;
//   @JsonKey()
//   int? v;
//   @JsonKey()
//   String? extPhone;
//   @JsonKey()
//   int? point;
//
//   /// Chứng minh thư nhân dân
//   @JsonKey()
//   String? identityCode;
//   @JsonKey()
//   String? identityAddress;
//   @JsonKey()
//   String? identityDate;
//   @JsonKey()
//   dynamic secondEmail;
//   @JsonKey()
//   String? taxId;
//   @JsonKey()
//   String? updatedBy;
//   @JsonKey()
//   String? codeDx;
//   @JsonKey()
//   dynamic timePullLatest;
//   @JsonKey()
//   int? level;
//   @JsonKey()
//   List<dynamic>? propertyUnitPullLatest;
//   @JsonKey()
//   String? dob;
//   @JsonKey()
//   String? gender;
//   @JsonKey()
//   dynamic erp;
//   @JsonKey()
//   String? avatar;
//   @JsonKey()
//   String? roleId;
//   @JsonKey()
//   String? posId;
//   @JsonKey()
//   bool? isManage;
//   @JsonKey()
//   String? relationIinviter;
//
//   ///Getter method
//   GenderType? get genderType {
//     return GenderTypeExtension.fromAPICode(gender);
//   }
//
//   DateTime? get getIdentityDate {
//     return AppDateUtils.fromDateAPIString(identityDate);
//   }
//
//   DateTime? get birthday {
//     if ((dob ?? "").isEmpty) {
//       return null;
//     }
//     return AppDateUtils.fromBirthdayAPIString(dob ?? "");
//   }
//
//   factory UserEntity.fromJson(Map<String, dynamic> json) =>
//       _$UserEntityFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserEntityToJson(this);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//         description,
//         active,
//         modifiedBy,
//         workingAt,
//         managerAt,
//         interestedArea,
//         socialUrls,
//         createdAt,
//         updatedAt,
//         staffIds,
//         id,
//         name,
//         code,
//         email,
//         status,
//         images,
//         phone,
//         attributes,
//         meetingEntityId,
//         v,
//         extPhone,
//         identityCode,
//         point,
//         identityAddress,
//         identityDate,
//         secondEmail,
//         taxId,
//         updatedBy,
//         codeDx,
//         timePullLatest,
//         level,
//         erp,
//         avatar,
//         roleId,
//         posId,
//         isManage,
//         relationIinviter,
//       ];
// }
