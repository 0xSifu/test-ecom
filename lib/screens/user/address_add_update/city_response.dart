class CityResponse {
    CityResponse({
        required this.cities,
    });

    final List<City> cities;

    factory CityResponse.fromMap(Map<String, dynamic> json){ 
        return CityResponse(
            cities: json["zones"] == null ? [] : List<City>.from(json["zones"]!.map((x) => City.fromMap(x))),
        );
    }

}

class City {
    City({
        required this.cityId,
        required this.provinceId,
        required this.name,
        required this.code,
        required this.status,
    });

    final String? cityId;
    final String? provinceId;
    final String? name;
    final String? code;
    final String? status;

    factory City.fromMap(Map<String, dynamic> json){ 
        return City(
            cityId: json["zone_id"],
            provinceId: json["country_id"],
            name: json["name"],
            code: json["code"],
            status: json["status"],
        );
    }

}
