import 'package:fluro/fluro.dart';
import 'package:ihz_bql/routers/router_handlers/update_profile_handler.dart';
import 'package:ihz_bql/routers/router_handlers/my_profile_handler.dart';
import 'package:ihz_bql/routers/router_handlers/course_list_handler.dart';
import 'package:ihz_bql/routers/router_handlers/contact_list_handler.dart';
import 'package:ihz_bql/routers/router_handlers/chat_conversation_handler.dart';
import 'package:ihz_bql/routers/router_handlers/chat_list_handler.dart';
import 'package:ihz_bql/routers/router_handlers/home_handler.dart';
import 'package:ihz_bql/routers/router_handlers/auth_router_handler.dart';

class Routes {
  static String root = "/";

  ///Auth
  static String signIn = "/signIn";
  static String intro = "/intro";
  static String signUp = "/signUp";
  static String forgotPassword = "/forgotPassword";

  static String home = '/home';
  static String chatList = '/chatList';
  static String chatConversation = '/chatConversation';
  static String contactList = '/contactList';
  static String courseList = '/courseList';
  static String myProfile = '/myProfile';
  static String updateProfile = '/updateProfile';
  static void configureRoutes(FluroRouter router) {
    router.define(
      updateProfile,
      handler: updateProfileHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      myProfile,
      handler: myProfileHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      courseList,
      handler: courseListHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      contactList,
      handler: contactListHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      chatConversation,
      handler: chatConversationHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      chatList,
      handler: chatListHandler,
      transitionType: TransitionType.inFromRight,
    );

    /// Home
    router.define(
      home,
      handler: homeHandler,
      transitionType: TransitionType.native,
    );

    /// Splash
    router.define(root, handler: splashHandler);

    /// Login
    router.define(
      signIn,
      handler: signInHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      signUp,
      handler: signUpHandler,
      transitionType: TransitionType.inFromRight,
    );
  }
}
