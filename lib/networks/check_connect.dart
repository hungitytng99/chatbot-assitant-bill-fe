import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnect {
  static Future<bool> checkConnect() async {
    final connectResult = await Connectivity().checkConnectivity();
    if (connectResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}