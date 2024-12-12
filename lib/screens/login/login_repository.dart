import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> signInWithGoogle();
  Future<LoginResponse> signInWithFacebook();
  Future<LoginResponse> signInWithApple();
  Future<LoginResponse> signInWithEmailAndPassword(String email, String password);
}

class LoginRepositoryImpl extends LoginRepository {
  final Dio _dio;
  LoginRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<LoginResponse> signInWithGoogle() async {
    final creds = await firebaseSignInWithGoogle();
    return loginSosmed(userCredential: creds, provider: "google.com", dio: _dio);
  }

  @override
  Future<LoginResponse> signInWithApple() async {
    final creds = await firebaseSignInWithApple();
    return loginSosmed(userCredential: creds, provider: "apple.com", dio: _dio);
  }
  
  @override
  Future<LoginResponse> signInWithEmailAndPassword(String email, String password) async {
    final dioResp = await _dio.post("account/login", data: FormData.fromMap({
      "email": email,
      "password": password
    }));
    final resp = LoginResponse.fromMap(dioResp.data);
    return resp;
  }
  
  @override
  Future<LoginResponse> signInWithFacebook() async {
    final creds = await firebaseSignInWithFacebook();
    return loginSosmed(userCredential: creds, provider: "facebook.com", dio: _dio);
  }

  static Future<UserCredential> firebaseSignInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final token = loginResult.accessToken?.tokenString;
    if (token != null) {
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }
    throw Exception("Token not found");
  }


  static Future<UserCredential> firebaseSignInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final googleSignIn = GoogleSignIn(
        scopes: ["email"]
      );
      await googleSignIn.signOut();  
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if (googleAuth?.accessToken == null && googleAuth?.idToken == null) {
        throw Exception("User cancelled the flow");
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      rethrow;
    }
  }


  static Future<UserCredential> firebaseSignInWithApple() async {
    try {
      final provider = AppleAuthProvider();
      provider.addScope("email");
      provider.addScope("name");
      return await FirebaseAuth.instance.signInWithProvider(provider);
    } catch (error) {
      rethrow;
    }
  }

  static Future<LoginResponse> loginSosmed({
    required UserCredential userCredential, 
    required String provider,
    required Dio dio
  }) async {
    final idToken = await userCredential.user?.getIdToken(true);
    final email = userCredential.user?.email;
    final uid = userCredential.user?.uid;
    final dioResp = await dio.post("account/login/login_sosmed", data: FormData.fromMap({
        "email": email,
        "provider": provider,
        "idToken": idToken,
        // "uid": uid
      }));
      final resp = LoginResponse.fromMap(dioResp.data);
      return resp;
  }
}