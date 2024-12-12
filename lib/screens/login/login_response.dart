import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginResponse {
    LoginResponse({
        required this.error,
        required this.success,
        required this.data,
        required this.token,
    });

    final String? error;
    final String? success;
    final LoginResponseData? data;
    final String? token;

    factory LoginResponse.fromMap(Map<String, dynamic> json){ 
        return LoginResponse(
            error: json['error'],
            success: json["success"],
            data: json["data"] == null ? null : LoginResponseData.fromMap(json["data"]),
            token: json["token"] ?? json["token_api"]
        );
    }

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": data?.toMap(),
        "token": token,
    };

    static final List<Function(LoginResponse?)> _loginDataChangedListeners = [];
    static Future<void> listenToLoginDataChanged(FlutterSecureStorage secureStorage, Function(LoginResponse?) listener) async {
      _loginDataChangedListeners.add(listener);
      listener(await getLoginData(secureStorage));
    }

    static Future<LoginResponse?> getLoginData(FlutterSecureStorage secureStorage) {
      return secureStorage.read(key: "login_response")
        .then((loginResponseStr) {
          if (loginResponseStr != null) {
            return LoginResponse.fromMap(jsonDecode(loginResponseStr));
          }
          return null;
        });
    }

    static Future<void> setLoginData(FlutterSecureStorage secureStorage, LoginResponse? login) async {

      if (login == null) {
        await secureStorage.delete(key: "login_response");
      } else {
        await secureStorage.write(key: "login_response", value: jsonEncode(login.toMap()));
      }
      for (var element in _loginDataChangedListeners) {
        element(login);
      }
    }

    static Future<LoginResponse?> getLoginDataForBiometric(FlutterSecureStorage secureStorage) {
      return secureStorage.read(key: "login_response_for_biometric")
        .then((loginResponseStr) {
          if (loginResponseStr != null) {
            return LoginResponse.fromMap(jsonDecode(loginResponseStr));
          }
          return null;
        });
    }

    static Future<void> setLoginDataForBiometric(FlutterSecureStorage secureStorage, LoginResponse? login) async {

      if (login == null) {
        await secureStorage.delete(key: "login_response_for_biometric");
      } else {
        await secureStorage.write(key: "login_response_for_biometric", value: jsonEncode(login.toMap()));
      }
      for (var element in _loginDataChangedListeners) {
        element(login);
      }
    }

}


class LoginResponseData {
    LoginResponseData({
        required this.customerId,
        required this.firstname,
        required this.lastname,
        required this.email,
    });

    final String? customerId;
    final String? firstname;
    final String? lastname;
    final String? email;

    factory LoginResponseData.fromMap(Map<String, dynamic> json){ 
        return LoginResponseData(
            customerId: json["customer_id"]?.toString(),
            firstname: json["firstname"],
            lastname: json["lastname"],
            email: json["email"],
        );
    }

    Map<String, dynamic> toMap() => {
        "customer_id": customerId,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
    };

}
