import 'api_service.dart';

class AuthResult {
  final bool success;
  final String? token;
  final String? message;

  AuthResult({required this.success, this.token, this.message});
}

class AuthService {
  static Future<AuthResult> login(String email, String password) async {
    final res = await ApiService.post("/auth/login", {
      "email": email,
      "password": password,
    });

    if (res["status"] == 200) {
      return AuthResult(success: true, token: res["body"]["access_token"]);
    }

    return AuthResult(
      success: false,
      message: res["body"]["detail"] ?? "Login failed",
    );
  }

  static Future<AuthResult> signup(String email, String password) async {
    final res = await ApiService.post("/auth/signup", {
      "email": email,
      "password": password,
    });

    if (res["status"] == 200) {
      return AuthResult(success: true);
    }

    return AuthResult(
      success: false,
      message: res["body"]["detail"] ?? "Signup failed",
    );
  }

  static Future<Map<String, dynamic>?> getMe(String token) async {
    final res = await ApiService.get("/users/me", token);

    if (res["status"] == 200) {
      return res["body"];
    }

    return null;
  }
}
