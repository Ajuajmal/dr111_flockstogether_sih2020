import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  removePreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('course');
    await sharedPreferences.remove('collegeId');
  }
}
