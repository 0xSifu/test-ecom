import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_response.dart';

abstract class WishlistRepository {
  Future<void> addWishlist(String productId);
  Future<void> removeWishlist(String productId);
  Future<WishlistResponse> getWishlist();
}

class WishlistRepositoryImpl extends WishlistRepository {
  final Dio _dio;
  WishlistRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<void> removeWishlist(String productId) async {
    await _dio.get("account/wishlist&remove=$productId");
    return;
  }


  @override
  Future<void> addWishlist(String productId) async {
    await _dio.post("account/wishlist/add", data: FormData.fromMap({
      "product_id": productId
    }));
    return;
  }

  @override
  Future<WishlistResponse> getWishlist() async {
    final dioResp = await _dio.get("account/wishlist");
    final res = WishlistResponse.fromMap(dioResp.data);
    return res;
  }
}