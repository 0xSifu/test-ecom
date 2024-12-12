class KecamatanResponse {
    KecamatanResponse({
        required this.kecamatans,
    });

    final List<Kecamatan> kecamatans;

    factory KecamatanResponse.fromMap(Map<String, dynamic> json){ 
        return KecamatanResponse(
            kecamatans: json["cities"] == null ? [] : List<Kecamatan>.from(json["cities"]!.map((x) => Kecamatan.fromMap(x))),
        );
    }

}

class Kecamatan {
    Kecamatan({
        required this.kecamatanId,
        required this.cityId,
        required this.code,
        required this.name,
        required this.status,
        required this.kurirTokoPrice,
        required this.kurirTokoStatus,
    });

    final String? kecamatanId;
    final String? cityId;
    final String? code;
    final String? name;
    final String? status;
    final String? kurirTokoPrice;
    final String? kurirTokoStatus;

    factory Kecamatan.fromMap(Map<String, dynamic> json){ 
        return Kecamatan(
            kecamatanId: json["city_id"],
            cityId: json["zone_id"],
            code: json["code"],
            name: json["name"],
            status: json["status"],
            kurirTokoPrice: json["kurir_toko_price"],
            kurirTokoStatus: json["kurir_toko_status"],
        );
    }

}
