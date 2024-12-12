class PromoPembayaranResponse {
    PromoPembayaranResponse({
        required this.promoPembayaran,
    });

    final List<PromoPembayaran> promoPembayaran;

    factory PromoPembayaranResponse.fromMap(Map<String, dynamic> json){ 
        return PromoPembayaranResponse(
            promoPembayaran: json["promo_pembayaran"] == null ? [] : List<PromoPembayaran>.from(json["promo_pembayaran"]!.map((x) => PromoPembayaran.fromMap(x))),
        );
    }

}

class PromoPembayaran {
    PromoPembayaran({
        required this.title,
        required this.informationId,
        required this.description,
        required this.promoPembayaranClass,
        required this.href,
        required this.image,
    });

    final String? title;
    final String? informationId;
    final String? description;
    final String? promoPembayaranClass;
    final String? href;
    final String? image;

    factory PromoPembayaran.fromMap(Map<String, dynamic> json){ 
        return PromoPembayaran(
            title: json["title"],
            informationId: json['information_id'],
            description: json["description"],
            promoPembayaranClass: json["class"],
            href: json["href"],
            image: json["image"],
        );
    }

}
