import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/user/voucher/apply_voucher_response.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_controller.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_list_response.dart';

abstract class VoucherRepository {

  Future<VoucherListResponse> getVouchers();
  Future<dynamic> claimBySearch({required String code, String? paymentMethod});
  Future<ApplyCouponResponse> claim({required String code, required VoucherClaimSource source, String? paymentMethod});
  Future<dynamic> removeActiveCoupon();

}

class VoucherRepositoryImpl extends VoucherRepository {
  final Dio _dio;
  VoucherRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<VoucherListResponse> getVouchers() async {
    final dioResp = await _dio.get("account/voucher");
    final res = VoucherListResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<dynamic> claimBySearch({required String code, String? paymentMethod}) async {
    final map = {
      "coupon": code,
      "payment": paymentMethod
    };
    map.removeWhere((key, value) => value == null);
    final dioResp = await _dio.post("account/voucher/claimBySearch", data: FormData.fromMap(map));
    return dioResp.data;
  }

  @override
  Future<ApplyCouponResponse> claim({required String code, required VoucherClaimSource source, String? paymentMethod}) async {
    final map = {
      "coupon": code,
      "payment": paymentMethod,
      "page": source.rawValue
    };
    map.removeWhere((key, value) => value == null);
    final dioResp = await _dio.post("account/voucher/claim", data: FormData.fromMap(map));
    return ApplyCouponResponse.fromMap(dioResp.data);
  }

  @override
  Future<dynamic> removeActiveCoupon() async {
    final dioResp = await _dio.post("checkout/cart/removeCoupon");
    return dioResp.data;
  }
}