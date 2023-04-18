
import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/profile/my_profile/my_profile_cubit.dart';
import 'package:ihz_bql/ui/pages/profile/my_profile/my_profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler myProfileHandler = new Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return MyProfileCubit();
    },
    child: MyProfilePage(),
  );
});
  
