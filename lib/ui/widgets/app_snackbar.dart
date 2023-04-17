///Use AppSnackBar from ui/commons/app_snackbar.dart
// import 'package:flutter/material.dart';
// import 'package:ihz_bql/common/app_colors.dart';
// import 'package:ihz_bql/common/app_images.dart';
//
// class SnackBarMessage {
//   final String? message;
//   final SnackBarType? type;
//
//   SnackBarMessage({
//     this.message,
//     this.type = SnackBarType.success,
//   });
// }
//
// enum SnackBarType {
//   success,
//   error,
//   info,
// }
//
// extension SnackBarTypeExtension on SnackBarType {
//   Color get backgroundColor {
//     switch (this) {
//       case SnackBarType.success:
//         return const Color(0xFF9FC2FF);
//       case SnackBarType.error:
//         return const Color(0xFFFFEDED);
//       default:
//         return const Color(0xFF9FC2FF);
//     }
//   }
//
//   Color get messageColor {
//     switch (this) {
//       case SnackBarType.success:
//         return AppColors.main;
//       case SnackBarType.error:
//         return const Color(0xFFFF0000);
//       default:
//         return AppColors.main;
//     }
//   }
//
//   Widget get prefixIcon {
//     switch (this) {
//       case SnackBarType.success:
//         return Icon(Icons.check_circle_outline, color: AppColors.main, size: 16);
//       case SnackBarType.error:
//         return Image.asset(AppImages.icWarning, width: 16, height: 16, fit: BoxFit.contain);
//       default:
//         return Icon(Icons.info_outline, color: AppColors.main, size: 16);
//     }
//   }
// }
//
// class AppSnackBar extends SnackBar {
//   final SnackBarMessage message;
//
//   AppSnackBar({Key? key,
//     required this.message,
//   }) : super(key: key,
//           elevation: 0,
//           content: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//               color: message.type?.backgroundColor,
//             ),
//             child: Row(
//               children: [
//                 Container(child: message.type?.prefixIcon),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(message.message ?? '',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: message.type?.messageColor,
//                         fontWeight: FontWeight.w300,
//                       )),
//                 ),
//               ],
//             ),
//           ),
//           padding: const EdgeInsets.all(28),
//           backgroundColor: Colors.transparent,
//         );
// }
