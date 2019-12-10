import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticateRepository {
  final String _tokenKey = 'token';
  final _storage = new FlutterSecureStorage();

  Future<bool> saveToken(String token) async {
    bool result = true;
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (e) {
      result = false;
    }
    return result == null ? false : result;
  }

  Future<bool> isExpired() async {
    bool result = false;
    await Future.delayed(Duration(seconds: 1));
    return result;
  }

  Future readToken() async {
    var result;
    try {
      result = await _storage.read(key: _tokenKey);
    } catch (e) {
      result = false;
    }
    return result == null ? false : result;
  }

  Future<bool> deleteToken() async {
    bool result = true;
    try {
      await _storage.delete(key: _tokenKey);
    } catch (e) {
      result = false;
    }
    return result == null ? false : result;
  }
}
