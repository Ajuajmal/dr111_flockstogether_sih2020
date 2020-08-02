import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final storage = FlutterSecureStorage();
  readToken() async {
    var accessToken = await storage.read(key: 'accesstoken');
    print('this is$accessToken');
    // String refreshToken = await storage.read(key: 'refreshtoken');
  }
}
