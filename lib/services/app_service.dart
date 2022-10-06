import 'package:shared_preferences/shared_preferences.dart';

class AppService 
{
  static SharedPreferences? prefs ;

  static void init () async
  {
    prefs = await SharedPreferences.getInstance();
  }
}