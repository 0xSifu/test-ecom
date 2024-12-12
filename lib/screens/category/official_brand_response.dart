class OfficialBrandsResponse {
    OfficialBrandsResponse({
        required this.categories,
    });

    final List<OfficialBrand> categories;

    factory OfficialBrandsResponse.fromMap(Map<String, dynamic> json){ 
        return OfficialBrandsResponse(
            categories: json["categories"] == null ? [] : List<OfficialBrand>.from(json["categories"]!.map((x) => OfficialBrand.fromMap(x))),
        );
    }

}

class OfficialBrand {
    OfficialBrand({
        required this.name,
        required this.image,
        required this.href,
    });

    final String? name;
    final String? image;
    final String? href;

    factory OfficialBrand.fromMap(Map<String, dynamic> json){ 
        return OfficialBrand(
            name: json["name"],
            image: json["image"],
            href: json["href"],
        );
    }

}
