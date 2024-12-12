class FilterBrandCategoryResponse {
    FilterBrandCategoryResponse({
        required this.filterBrand,
        required this.manufacturer,
    });

    final List<dynamic> filterBrand;
    final List<Manufacturer> manufacturer;

    factory FilterBrandCategoryResponse.fromMap(Map<String, dynamic> json){ 
        return FilterBrandCategoryResponse(
            filterBrand: json["filter_brand"] == null ? [] : List<dynamic>.from(json["filter_brand"]!.map((x) => x)),
            manufacturer: json["manufacturer"] == null ? [] : List<Manufacturer>.from(json["manufacturer"]!.map((x) => Manufacturer.fromMap(x))),
        );
    }

}

class Manufacturer {
    Manufacturer({
        required this.manufacturerId,
        required this.name,
    });

    final String? manufacturerId;
    final String? name;

    factory Manufacturer.fromMap(Map<String, dynamic> json){ 
        return Manufacturer(
            manufacturerId: json["manufacturer_id"],
            name: json["name"],
        );
    }

}
