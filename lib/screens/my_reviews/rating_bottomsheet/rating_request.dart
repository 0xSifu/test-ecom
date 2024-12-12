import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class RatingRequest {
  final List<XFile> videos;
  final List<XFile> photos;
  final String productId;
  final String rating;
  final String text;
  final String orderId;
  RatingRequest({
    required this.videos,
    required this.photos,
    required this.productId,
    required this.rating,
    required this.text,
    required this.orderId,
  });


  Future<Map<String, dynamic>> toMap() async {
    final map =  <String, dynamic>{
      'product_id': productId,
      'rating': rating,
      'text': text,
      'order_id': orderId,
    };
    for (var e in videos.indexed) {
      map["video[${e.$1}]"] = await MultipartFile.fromFile(e.$2.path, contentType: MediaType.parse(lookupMimeType(e.$2.path) ?? ""));
    }
    for (var e in photos.indexed) {
      map["photo[${e.$1}]"] = await MultipartFile.fromFile(e.$2.path, contentType: MediaType.parse(lookupMimeType(e.$2.path) ?? ""));
    }

    return map;
  }
}
