# GUIDE
#./hobbit.sh c filename file_path
# Ex: ./hobbit.sh c payment_info cart/payment_info
# This command will create file SCREEN_FOLDER/cart/payment_info
# and create three file: payment_info_cubit,payment_info_state,payment_info_page
# hobbit.sh c home homepage

# Configs
SCREEN_FOLDER="ui/pages"
ROUTER_FOLDER="routers"

# Helper function
exitApp()
{
  echo 'Invalid CLI';
  exit 1;
}

# Check arguments
if [[ $# -eq 0 ]];
then
  exitApp;
fi

# Excute
## If create cubit
if [ "$1" == "c" ] || [ "$1" == "create" ]
then
  if [ "$2" == "" ]
  then
    echo 'Missing filename';
    exit 1;
  fi

  PASCAL_CASE_NAME=$(echo "$2"  | sed -r 's/(^|_)([a-z])/\U\2/g')
  CAMEL_CASE_NAME=$(echo "$2"  | sed -r 's/([a-z]+)_([a-z])([a-z]+)/\1\U\2\L\3/g')

  echo "Start generate files for $2";

  CUBIT="
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part '$2_state.dart';

class ${PASCAL_CASE_NAME}Cubit extends Cubit<${PASCAL_CASE_NAME}State> {
  ${PASCAL_CASE_NAME}Cubit() : super(${PASCAL_CASE_NAME}State());
}
  ";

   STATE="
part of '$2_cubit.dart';

class ${PASCAL_CASE_NAME}State extends Equatable {
  @override
  List<Object?> get props => [];

  ${PASCAL_CASE_NAME}State();

  ${PASCAL_CASE_NAME}State copyWith() {
    return ${PASCAL_CASE_NAME}State();
  }
}
  ";

  PAGE="
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';

class ${PASCAL_CASE_NAME}Page extends StatefulWidget {
  ${PASCAL_CASE_NAME}Page({
    Key? key,
  }) : super(key: key);
  @override
  _${PASCAL_CASE_NAME}PageState createState() => _${PASCAL_CASE_NAME}PageState();
}

class _${PASCAL_CASE_NAME}PageState extends State<${PASCAL_CASE_NAME}Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.primaryLighter,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: AppColors.textBlack,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
        title: _buildAppBar(context),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryLighter,
          ),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('DETAIL'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack _buildAppBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 34,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thông tin đơn hàng',
                style: AppTextStyle.blackS18Bold,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 8,
              ),
              child: Image.asset(
                AppImages.icBack,
                color: AppColors.textBlack,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }
}
  ";

   HANDLER_NOT_EXIST="
import 'package:fluro/fluro.dart';
import 'package:ihz_bql/$SCREEN_FOLDER/$3/$2_cubit.dart';
import 'package:ihz_bql/$SCREEN_FOLDER/$3/$2_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler ${CAMEL_CASE_NAME}Handler = new Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return ${PASCAL_CASE_NAME}Cubit();
    },
    child: ${PASCAL_CASE_NAME}Page(),
  );
});
  ";

  HANDLER_EXIST="
Handler ${CAMEL_CASE_NAME}Handler = new Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return ${PASCAL_CASE_NAME}Cubit();
    },
    child: ${PASCAL_CASE_NAME}Page(),
  );
});
  ";

##  Start process
### Prepare stored folder
  if [ "$3" != 0 ];
  then
    SCREEN_FOLDER="lib/$SCREEN_FOLDER/$3"
  fi
### Start
#### File
  mkdir -p "${SCREEN_FOLDER}" && touch "${SCREEN_FOLDER}/$2_cubit.dart" && echo "$CUBIT" > "${SCREEN_FOLDER}/$2_cubit.dart"
  mkdir -p "${SCREEN_FOLDER}" && touch "${SCREEN_FOLDER}/$2_state.dart" && echo "$STATE" > "${SCREEN_FOLDER}/$2_state.dart"
  mkdir -p "${SCREEN_FOLDER}" && touch "${SCREEN_FOLDER}/$2_page.dart" && echo "$PAGE" > "${SCREEN_FOLDER}/$2_page.dart"
#### Router handler
  if test -f "lib/$ROUTER_FOLDER/router_handlers/$2_handler.dart"
  then
    echo "${HANDLER_EXIST}" >> "lib/$ROUTER_FOLDER/router_handlers/$2_handler.dart";
  else
    touch "lib/$ROUTER_FOLDER/router_handlers/$2_handler.dart"
    echo "${HANDLER_NOT_EXIST}" > "lib/$ROUTER_FOLDER/router_handlers/$2_handler.dart";
  fi
#### Router
  ROUTE_CONFIG_LINE_NUMBER=$(grep -rne "static void configureRoutes(FluroRouter router) {" "lib/$ROUTER_FOLDER/routers.dart" | cut -d : -f 1)
  sed -i "$ROUTE_CONFIG_LINE_NUMBER a router.define(${CAMEL_CASE_NAME},handler:${CAMEL_CASE_NAME}Handler,transitionType:TransitionType.native,);" "lib/$ROUTER_FOLDER/routers.dart"
  sed -i "$((ROUTE_CONFIG_LINE_NUMBER-1)) a static String $CAMEL_CASE_NAME = '/$CAMEL_CASE_NAME';" "lib/$ROUTER_FOLDER/routers.dart"
  sed -i "1 a import\ \'package:ihz_bql/$ROUTER_FOLDER/router_handlers/$2_handler.dart';" "lib/$ROUTER_FOLDER/routers.dart"
  flutter format "lib/$ROUTER_FOLDER/routers.dart"
  printf "Successfully! Have a good day!\n";
  printf "Navigate to page by: \n";
  echo -e "\x1b[1;31m Application.router!.navigateTo(context, Routes.$CAMEL_CASE_NAME); \e[0m"
fi

