class MenuResponse {
    MenuResponse({
        required this.categories,
    });

    final List<Category> categories;

    factory MenuResponse.fromMap(Map<String, dynamic> json){ 
        return MenuResponse(
            categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromMap(x))),
        );
    }

}

class Category {
    Category({
        required this.name,
        required this.categoryId,
        required this.children,
        required this.column,
        required this.href,
        required this.icon,
        required this.childLv3,
        required this.childLv4,
    });

    final String? name;
    final String? categoryId;
    final List<Category> children;
    final String? column;
    final String? href;
    final String? icon;
    final List<Category>? childLv3;
    final List<Category>? childLv4;

    factory Category.fromMap(Map<String, dynamic> json){
        return Category(
            name: json["name"],
            categoryId: json['category_id'],
            children: json["children"] == null ? [] : List<Category>.from(json["children"]!.map((x) => Category.fromMap(x))),
            column: json["column"],
            href: json["href"],
            icon: json["icon"],
            childLv3: json["child_lv3"] == null ? null : List<Category>.from(json["child_lv3"]!.map((x) => Category.fromMap(x))),
            childLv4: json["child_lv4"] == null ? null : null// List<Category?>.from(json["child_lv4"]!.map((x) => x is Map<String, dynamic> ? Category.fromMap(x) : null)).where((element) => element != null).map((e) => e!).toList(),
        );
    }

}