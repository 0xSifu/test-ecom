class ProvinceResponse {
    ProvinceResponse({
        required this.provinces,
    });

    final List<Province> provinces;

    factory ProvinceResponse.fromMap(Map<String, dynamic> json){ 
        return ProvinceResponse(
            provinces: json["countries"] == null ? [] : List<Province>.from(json["countries"]!.map((x) => Province.fromMap(x))),
        );
    }

}

class Province {
    Province({
        required this.provinceId,
        required this.name,
        required this.isoCode2,
        required this.isoCode3,
        required this.addressFormat,
        required this.postcodeRequired,
        required this.status,
    });

    final String? provinceId;
    final String? name;
    final String? isoCode2;
    final String? isoCode3;
    final String? addressFormat;
    final String? postcodeRequired;
    final String? status;

    factory Province.fromMap(Map<String, dynamic> json){ 
        return Province(
            provinceId: json["country_id"],
            name: json["name"],
            isoCode2: json["iso_code_2"],
            isoCode3: json["iso_code_3"],
            addressFormat: json["address_format"],
            postcodeRequired: json["postcode_required"],
            status: json["status"],
        );
    }

}
