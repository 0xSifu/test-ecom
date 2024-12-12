class NewsResponse {
    NewsResponse({
        required this.blog,
    });

    final List<Blog> blog;

    factory NewsResponse.fromMap(Map<String, dynamic> json){ 
        return NewsResponse(
            blog: json["blog"] == null ? [] : List<Blog>.from(json["blog"]!.map((x) => Blog.fromMap(x))),
        );
    }

}

class Blog {
    Blog({
        required this.blogId,
        required this.sortOrder,
        required this.meta,
        required this.status,
        required this.image,
        required this.categoryId,
        required this.start,
        required this.languageId,
        required this.title,
        required this.description,
        required this.metaTitle,
        required this.metaDescription,
        required this.metaKeyword,
        required this.storeId,
        required this.video
    });

    final String? blogId;
    final String? sortOrder;
    final String? meta;
    final String? status;
    final String? image;
    final String? categoryId;
    final DateTime? start;
    final String? languageId;
    final String? title;
    final String? description;
    final String? metaTitle;
    final String? metaDescription;
    final String? metaKeyword;
    final String? storeId;
    final String? video;

    factory Blog.fromMap(Map<String, dynamic> json){ 
        return Blog(
            blogId: json["blog_id"],
            sortOrder: json["sort_order"],
            meta: json["meta"],
            status: json["status"],
            image: json["image"],
            categoryId: json["category_id"],
            start: DateTime.tryParse(json["start"] ?? ""),
            languageId: json["language_id"],
            title: json["title"],
            description: json["description"],
            metaTitle: json["meta_title"],
            metaDescription: json["meta_description"],
            metaKeyword: json["meta_keyword"],
            storeId: json["store_id"],
            video: json["video"]
        );
    }

}
