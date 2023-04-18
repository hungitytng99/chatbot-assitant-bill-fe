import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/homepage/home_cubit.dart';
import 'package:ihz_bql/ui/pages/homepage/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler homeHandler = Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return HomeCubit();
    },
    child: HomePage(),
  );
});
