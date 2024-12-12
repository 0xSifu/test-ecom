
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateController<T> extends GetxController {
  final _state = Rx<T?>(null);
  T? get state => _state.value;
  final _error = Rx<dynamic>(null);
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  
  Future<T> futurize(Future<T> Function() future, {T? initialData, bool shouldShowLoading = true, Function(T)? onFinishLoading}) {
    if (initialData != null) {
      _state.value = initialData;
      if (shouldShowLoading) _isLoading.value = true;
    }
    if (shouldShowLoading) _isLoading.value = true;
    return future()
      .then((value) {
        _error.value = null;
        _isLoading.value = false;
        _state.value = value;
        onFinishLoading?.call(value);
        return value;
      })
      .catchError((error) {
        _isLoading.value = false;
        _error.value = error;
        final errorFromAPI = error is DioException ? error.response?.data["error"] : null;
        if (errorFromAPI != null) {
          Get.showSnackbar(GetSnackBar(
            message: errorFromAPI ?? error.toString(),
            duration: const Duration(seconds: 2),
          ));
        }
        throw error;
      });
  }

  Widget obx(Widget Function(T?) builder, { Widget? onLoading, Widget Function(dynamic)? onError}) {
    return Obx(() {
      if (_isLoading.value) {
        return onLoading ?? const Center(child: CircularProgressIndicator());
      }
      if (_error.value != null) {
        return onError?.call(_error.value) ?? (kDebugMode ? Text(_error.value.toString()) : Container());
      }
      return builder(state);
    });
  }
}