import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

class CategoryResponse {
    CategoryResponse({
        required this.headingTitleInfo,
        required this.descriptionInfo,
        required this.path,
        required this.actionParent,
        required this.uri,
        required this.uris,
        required this.maxPrice,
        required this.manufacturer,
        required this.categoryFiltersList,
        required this.banners,
        required this.thumb,
        required this.description,
        required this.categories,
        required this.products,
        required this.ogImage,
    });

    final String? headingTitleInfo;
    final String? descriptionInfo;
    final String? path;
    final String? actionParent;
    final String? uri;
    final String? uris;
    final double? maxPrice;
    final List<Manufacturer> manufacturer;
    final List<CategoryFiltersList> categoryFiltersList;
    final List<BannerData> banners;
    final String? thumb;
    final String? description;
    final List<dynamic> categories;
    final List<Product> products;
    final String? ogImage;

    factory CategoryResponse.fromMap(Map<String, dynamic> json){ 
        return CategoryResponse(
            headingTitleInfo: json["heading_title_info"],
            descriptionInfo: json["description_info"],
            path: json["path"],
            actionParent: json["action_parent"],
            uri: json["uri"],
            uris: json["uris"],
            maxPrice: json['max_price'] == null ? null : double.tryParse(json['max_price']),
            manufacturer: json["manufacturer"] == null ? [] : List<Manufacturer>.from(json["manufacturer"]!.map((x) => Manufacturer.fromMap(x))),
            categoryFiltersList: json["category_filters_list"] == null ? [] : List<CategoryFiltersList>.from(json["category_filters_list"]!.map((x) => CategoryFiltersList.fromMap(x))),
            banners: json["banners"] == null ? [] : List<BannerData>.from(json["banners"]!.map((x) => BannerData.fromMap(x))),
            thumb: json["thumb"],
            description: json["description"],
            categories: json["categories"] == null ? [] : List<dynamic>.from(json["categories"]!.map((x) => x)),
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
            ogImage: json["og_image"],
        );
    }

}

class BannerData {
    BannerData({
        required this.image,
    });

    final String? image;

    factory BannerData.fromMap(Map<String, dynamic> json){ 
        return BannerData(
            image: json["image"],
        );
    }

}

class CategoryFiltersList {
    CategoryFiltersList({
        required this.groupName,
        required this.detail,
    });

    final String? groupName;
    final List<CategoryFiltersListDetail> detail;

    factory CategoryFiltersList.fromMap(Map<String, dynamic> json){ 
        return CategoryFiltersList(
            groupName: json["group_name"],
            detail: json["detail"] == null ? [] : List<CategoryFiltersListDetail>.from(json["detail"]!.map((x) => CategoryFiltersListDetail.fromMap(x))),
        );
    }

}

class CategoryFiltersListDetail {
    CategoryFiltersListDetail({
        required this.filterId,
        required this.filterGroupId,
        required this.sortOrder,
        required this.productId,
        required this.languageId,
        required this.name,
    });

    final String? filterId;
    final String? filterGroupId;
    final String? sortOrder;
    final String? productId;
    final String? languageId;
    final String? name;

    factory CategoryFiltersListDetail.fromMap(Map<String, dynamic> json){ 
        return CategoryFiltersListDetail(
            filterId: json["filter_id"],
            filterGroupId: json["filter_group_id"],
            sortOrder: json["sort_order"],
            productId: json["product_id"],
            languageId: json["language_id"],
            name: json["name"],
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