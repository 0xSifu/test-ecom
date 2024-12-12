class KelurahanResponse {
    KelurahanResponse({
        required this.kelurahans,
    });

    final List<Kelurahan> kelurahans;

    factory KelurahanResponse.fromMap(Map<String, dynamic> json){ 
        return KelurahanResponse(
            kelurahans: json["kelurahan"] == null ? [] : List<Kelurahan>.from(json["kelurahan"]!.map((x) => Kelurahan.fromMap(x))),
        );
    }

}

class Kelurahan {
    Kelurahan({
        required this.id,
        required this.kelurahan,
        required this.kecamatan,
        required this.kodepos,
        required this.status,
        required this.cityId,
        required this.zoneId,
        required this.code,
        required this.name,
        required this.kurirTokoPrice,
        required this.kurirTokoStatus,
    });

    final String? id;
    final String? kelurahan;
    final String? kecamatan;
    final String? kodepos;
    final String? status;
    final String? cityId;
    final String? zoneId;
    final String? code;
    final String? name;
    final String? kurirTokoPrice;
    final String? kurirTokoStatus;

    factory Kelurahan.fromMap(Map<String, dynamic> json){ 
        return Kelurahan(
            id: json["id"],
            kelurahan: json["kelurahan"],
            kecamatan: json["kecamatan"],
            kodepos: json["kodepos"],
            status: json["status"],
            cityId: json["city_id"],
            zoneId: json["zone_id"],
            code: json["code"],
            name: json["name"],
            kurirTokoPrice: json["kurir_toko_price"],
            kurirTokoStatus: json["kurir_toko_status"],
        );
    }

}
