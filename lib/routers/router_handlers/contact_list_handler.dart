
import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/contact/contact_list/contact_list_cubit.dart';
import 'package:ihz_bql/ui/pages/contact/contact_list/contact_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler contactListHandler = new Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return ContactListCubit();
    },
    child: ContactListPage(),
  );
});
  
