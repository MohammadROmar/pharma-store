class Auth {
  static String? _token;

  static String? get token {
    return _token;
  }

  static void setToken(String? token) {
    _token = token;
  }
}
