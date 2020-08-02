import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthenticationHelper {
  final storage = FlutterSecureStorage();

  accessTokenExpiryCheck() async {
    String accessToken = await storage.read(key: 'accesstoken');

    bool isTokenExpired = JwtDecoder.isExpired(accessToken);

    return isTokenExpired;
  }

  refreshTokenExpiryCheck() async {
    String refreshToken = await storage.read(key: 'refreshtoken');
    bool isTokenExpired = JwtDecoder.isExpired(refreshToken);
    return isTokenExpired;
  }
}
