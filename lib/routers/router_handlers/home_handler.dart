import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/homepage/home_cubit.dart';
import 'package:ihz_bql/ui/pages/homepage/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler homeHandler = Handler(handlerFunc: (context, parameters) {
  HomePageArgument param = context!.arguments as HomePageArgument;
  return BlocProvider(
    create: (context) {
      return HomeCubit();
    },
    child: HomePage(
      pageIndex: param.pageIndex,
      expertEntity: param.expertEntity,
    ),
  );
});
