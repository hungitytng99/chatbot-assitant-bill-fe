import 'env_configs.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = 'INSIDE';

  static Environment env = Environment.prod;

  static String get envName => env.envName;

  static String get baseUrl => env.baseUrl;

  ///API header
  // static const String apiHeaderXClientCodeKey = 'x-client-code';
  // static const String apiHeaderXClientCode = 'REAL_AGENT';
  // static const String apiHeaderAppNameKey = 'app-name';
  // static const String apiHeaderAppName = 'REAL_BUILDING';

  ///Paging
  static const pageSize = 20;
  static const pageSizeMax = 1000;

  ///Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'vi';

  ///DateFormat
  static const dateAPIFormat = 'dd/MM/yyyy';
  static const dateDisplayFormat = 'dd/MM/yyyy';
  static const dateTimeAPIFormat =
      "MM/dd/yyyy'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';
  static const timeFormat = 'HH:mm';

  static const dateTimeAPIFormatParam =
      "yyyy-MM-ddTHH:mm:ss.mmm";
  static const dateAPIFormatParam =
      "yyyy-MM-dd";
  static const timeAPIFormatParam =
      "THH:mm:ss.mmm";

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  // static const fontFamily = 'Roboto';
  static const fontFamily = 'Quicksand';

  ///Max file
  static const maxAttachFile = 5;

  static const secondsNotificationReloadTime = 15;
  static const double FILE_SIZE_LIMITED = 10;
}
