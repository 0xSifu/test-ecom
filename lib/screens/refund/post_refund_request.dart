import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class PostRefundRequest {
  final List<XFile> videos;
  final List<XFile> photos;
  final String reason;
  final List<String> productIds;
  final String? otherReasonNotes;
  final String orderId;
  final String accountName;
  final String accountNo;
  final String bankName;

  PostRefundRequest({
    required this.videos,
    required this.photos,
    required this.reason,
    required this.productIds,
    required this.otherReasonNotes,
    required this.orderId,
    required this.accountName,
    required this.accountNo,
    required this.bankName,
  });

  Future<Map<String, dynamic>> toMap() async {
    final map = <String, dynamic>{
      "reason": reason,
      "other_reason_notes": otherReasonNotes,
      "order_id": orderId,
      "nama_rekening": accountName,
      "nama_bank": bankName,
      "norek": accountNo
    };

    for (var video in videos.indexed) {
      map['video[${video.$1}]'] = await MultipartFile.fromFile(video.$2.path, contentType: MediaType.parse(lookupMimeType(video.$2.path) ?? ""));
    }
    for (var photo in photos.indexed) {
      map['photo[${photo.$1}]'] = await MultipartFile.fromFile(photo.$2.path, contentType: MediaType.parse(lookupMimeType(photo.$2.path) ?? ""));
    }
    for (var product in productIds.indexed) {
      map['product[${product.$1}]'] = product.$2;
    }
    return map;
  }
  
}
