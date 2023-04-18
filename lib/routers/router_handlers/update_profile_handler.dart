
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/ui/pages/profile/update_profile/update_profile_cubit.dart';
import 'package:ihz_bql/ui/pages/profile/update_profile/update_profile_page.dart';

Handler updateProfileHandler = Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return UpdateProfileCubit();
    },
    child: UpdateProfilePage(),
  );
});