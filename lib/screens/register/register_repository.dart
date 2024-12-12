import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/login/login_repository.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';

abstract class RegisterRepository {
  Future<LoginResponse> signInWithGoogle();
  Future<LoginResponse> signInWithFacebook();
  Future<LoginResponse> signInWithApple();
  Future<LoginResponse> register(String email, String password, String confirmationPassword, String name, String phone);
}

class RegisterRepositoryImpl extends RegisterRepository {
  final Dio _dio;
  RegisterRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<LoginResponse> signInWithGoogle() async {
    final creds = await LoginRepositoryImpl.firebaseSignInWithGoogle();
    return LoginRepositoryImpl.loginSosmed(userCredential: creds, provider: "google.com", dio: _dio);
  }
  
  @override
  Future<LoginResponse> register(String email, String password, String confirmationPassword, String name, String phone) async {
    final dioResp = await _dio.post("account/register", data: FormData.fromMap({
      "email": email,
      "fullname": name,
      "phone": phone,
      "password": password,
      "confirm": confirmationPassword,
      "agree": 1,
      "newsletter": 0
    }));
    final resp = LoginResponse.fromMap(dioResp.data);
    return resp;
  }
  
  @override
  Future<LoginResponse> signInWithFacebook() async {
    final creds = await LoginRepositoryImpl.firebaseSignInWithFacebook();
    return LoginRepositoryImpl.loginSosmed(userCredential: creds, provider: "facebook.com", dio: _dio);
  }

  @override
  Future<LoginResponse> signInWithApple() async {
    final creds = await LoginRepositoryImpl.firebaseSignInWithApple();
    return LoginRepositoryImpl.loginSosmed(userCredential: creds, provider: "apple.com", dio: _dio);
  }
}