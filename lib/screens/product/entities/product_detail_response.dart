import 'package:intl/intl.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

class ProductDetailResponse {
    ProductDetailResponse({
        required this.breadcrumbs,
        required this.headingTitle,
        required this.textSelect,
        required this.textManufacturer,
        required this.textModel,
        required this.textReward,
        required this.textPoints,
        required this.textStock,
        required this.textDiscount,
        required this.textTax,
        required this.textOption,
        required this.textMinimum,
        required this.textWrite,
        required this.textLogin,
        required this.textNote,
        required this.textTags,
        required this.textRelated,
        required this.textPaymentRecurring,
        required this.textLoading,
        required this.entryQty,
        required this.entryName,
        required this.entryReview,
        required this.entryRating,
        required this.entryGood,
        required this.entryBad,
        required this.buttonCart,
        required this.buttonWishlist,
        required this.buttonCompare,
        required this.buttonUpload,
        required this.buttonContinue,
        required this.warranty,
        required this.tabDescription,
        required this.tabAttribute,
        required this.tabReview,
        required this.productId,
        required this.manufacturer,
        required this.manufacturers,
        required this.model,
        required this.video,
        required this.reward,
        required this.points,
        required this.sku,
        required this.description,
        required this.freeItem,
        required this.qty,
        required this.stock,
        required this.realStock,
        required this.popup,
        required this.thumb,
        required this.images,
        required this.price,
        required this.realPrice,
        required this.garansiName,
        required this.garansiPrice,
        required this.flashSaleDate,
        required this.special,
        required this.flashSalePrice,
        required this.discSp,
        required this.hemat,
        required this.tax,
        required this.discounts,
        required this.options,
        required this.stockWarehouse,
        required this.minimum,
        required this.reviewStatus,
        required this.reviewGuest,
        required this.customerName,
        required this.reviews,
        required this.rating,
        required this.listReview,
        required this.captcha,
        required this.salesQty,
        required this.share,
        required this.attributeGroups,
        required this.productsRelated,
        required this.productsSuperDeal,
        required this.category,
        required this.coupon,
        required this.tags,
        required this.descriptionInfo,
        required this.recurrings,
        required this.cart,
        required this.columnLeft,
        required this.columnRight,
        required this.contentTop,
        required this.contentBottom,
        required this.footer,
        required this.header,
    });

    final List<Breadcrumb> breadcrumbs;
    final String? headingTitle;
    final String? textSelect;
    final String? textManufacturer;
    final String? textModel;
    final String? textReward;
    final String? textPoints;
    final String? textStock;
    final String? textDiscount;
    final String? textTax;
    final String? textOption;
    final String? textMinimum;
    final String? textWrite;
    final String? textLogin;
    final String? textNote;
    final String? textTags;
    final String? textRelated;
    final String? textPaymentRecurring;
    final String? textLoading;
    final String? entryQty;
    final String? entryName;
    final String? entryReview;
    final String? entryRating;
    final String? entryGood;
    final String? entryBad;
    final String? buttonCart;
    final String? buttonWishlist;
    final String? buttonCompare;
    final String? buttonUpload;
    final String? buttonContinue;
    final String? warranty;
    final String? tabDescription;
    final String? tabAttribute;
    final String? tabReview;
    final int? productId;
    final String? manufacturer;
    final String? manufacturers;
    final String? model;
    final String? video;
    final String? reward;
    final String? points;
    final String? sku;
    final String? description;
    final String? freeItem;
    final String? qty;
    final String? stock;
    final int? realStock;
    final String? popup;
    final String? thumb;
    final List<ImageData> images;
    final String? price;
    final double? realPrice;
    final String? garansiName;
    final int? garansiPrice;
    final DateTime? flashSaleDate;
    final String? special;
    final String? flashSalePrice;
    final double? discSp;
    final String? hemat;
    final String? tax;
    final List<dynamic> discounts;
    final List<ProductOption> options;
    final List<StockWarehouse> stockWarehouse;
    final String? minimum;
    final String? reviewStatus;
    final bool? reviewGuest;
    final String? customerName;
    final int? reviews;
    final int? rating;
    final List<ListReview> listReview;
    final String? captcha;
    final String? salesQty;
    final String? share;
    final List<AttributeGroup> attributeGroups;
    final List<Product> productsRelated;
    final List<Product> productsSuperDeal;
    final String? category;
    final List<dynamic> coupon;
    final List<Tag> tags;
    final String? descriptionInfo;
    final List<dynamic> recurrings;
    final String? cart;
    final dynamic columnLeft;
    final String? columnRight;
    final String? contentTop;
    final String? contentBottom;
    final String? footer;
    final String? header;

    factory ProductDetailResponse.fromMap(Map<String, dynamic> json){ 
        return ProductDetailResponse(
            breadcrumbs: json["breadcrumbs"] == null ? [] : List<Breadcrumb>.from(json["breadcrumbs"]!.map((x) => Breadcrumb.fromMap(x))),
            headingTitle: json["heading_title"],
            textSelect: json["text_select"],
            textManufacturer: json["text_manufacturer"],
            textModel: json["text_model"],
            textReward: json["text_reward"],
            textPoints: json["text_points"],
            textStock: json["text_stock"],
            textDiscount: json["text_discount"],
            textTax: json["text_tax"],
            textOption: json["text_option"],
            textMinimum: json["text_minimum"],
            textWrite: json["text_write"],
            textLogin: json["text_login"],
            textNote: json["text_note"],
            textTags: json["text_tags"],
            textRelated: json["text_related"],
            textPaymentRecurring: json["text_payment_recurring"],
            textLoading: json["text_loading"],
            entryQty: json["entry_qty"],
            entryName: json["entry_name"],
            entryReview: json["entry_review"],
            entryRating: json["entry_rating"],
            entryGood: json["entry_good"],
            entryBad: json["entry_bad"],
            buttonCart: json["button_cart"],
            buttonWishlist: json["button_wishlist"],
            buttonCompare: json["button_compare"],
            buttonUpload: json["button_upload"],
            buttonContinue: json["button_continue"],
            warranty: json["warranty"],
            tabDescription: json["tab_description"],
            tabAttribute: json["tab_attribute"],
            tabReview: json["tab_review"],
            productId: json["product_id"],
            manufacturer: json["manufacturer"],
            manufacturers: json["manufacturers"],
            model: json["model"],
            video: json["video"],
            reward: json["reward"],
            points: json["points"],
            sku: json["sku"],
            description: json["description"],
            freeItem: json["free_item"],
            qty: json["qty"],
            stock: json["stock"],
            realStock: int.tryParse(json["real_stock"]?.toString() ?? ""),
            popup: json["popup"],
            thumb: json["thumb"],
            images: json["images"] == null ? [] : List<ImageData>.from(json["images"]!.map((x) => ImageData.fromMap(x))),
            price: json["price"],
            realPrice: double.tryParse(json["real_price"]?.toString() ?? ""),
            garansiName: json["garansi_name"],
            garansiPrice: json["garansi_price"],
            flashSaleDate: DateFormat("yyyy-MM-dd HH:mm:ss").tryParse(json["flash_sale_date"]?.toString() ?? ""),
            special: json['special'] is bool ? null : json["special"]?.toString(),
            flashSalePrice: json['flash_sale_price'] is bool ? null : json["flash_sale_price"]?.toString(),
            discSp: double.tryParse(json['disc_sp']?.toString() ?? ""),
            hemat: json['hemat'] is bool ? null : json['hemat']?.toString(),
            tax: json['tax'] is bool ? null : json["tax"]?.toString(),
            discounts: json["discounts"] == null ? [] : List<dynamic>.from(json["discounts"]!.map((x) => x)),
            options: json["options"] == null ? [] : List<ProductOption>.from(json["options"]!.map((x) => ProductOption.fromMap(x))),
            stockWarehouse: json["stock_warehouse"] == null ? [] : List<StockWarehouse>.from(json["stock_warehouse"]!.map((x) => StockWarehouse.fromMap(x))),
            minimum: json["minimum"],
            reviewStatus: json["review_status"],
            reviewGuest: json["review_guest"],
            customerName: json["customer_name"],
            reviews: json["reviews"],
            rating: json["rating"],
            listReview: json["list_review"] == null ? [] : List<ListReview>.from(json["list_review"]!.map((x) => ListReview.fromMap(x))),
            captcha: json["captcha"],
            salesQty: json["sales_qty"]?.toString(),
            share: json["share"],
            attributeGroups: json["attribute_groups"] == null ? [] : List<AttributeGroup>.from(json["attribute_groups"]!.map((x) => AttributeGroup.fromMap(x))),
            productsRelated: json["products_related"] == null ? [] : List<Product>.from(json["products_related"]!.map((x) => Product.fromMap(x))),
            productsSuperDeal: json["products_super_deal"] == null ? [] : List<Product>.from(json["products_super_deal"]!.map((x) => Product.fromMap(x))),
            category: json["category"],
            coupon: json["coupon"] == null ? [] : List<dynamic>.from(json["coupon"]!.map((x) => x)),
            tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromMap(x))),
            descriptionInfo: json["description_info"],
            recurrings: json["recurrings"] == null ? [] : List<dynamic>.from(json["recurrings"]!.map((x) => x)),
            cart: json["cart"],
            columnLeft: json["column_left"],
            columnRight: json["column_right"],
            contentTop: json["content_top"],
            contentBottom: json["content_bottom"],
            footer: json["footer"],
            header: json["header"],
        );
    }

    Product get toProduct => Product(
      description: description ?? "",
      disc: discSp,
      href: share ?? "",
      logoBrand: "",
      model: model ?? "",
      name: headingTitle ?? "",
      price: price ?? "",
      priceFlashSale: flashSalePrice,
      productId: productId?.toString() ?? "",
      qtySold: salesQty,
      quantity: qty,
      rating: rating?.toDouble() ?? 0,
      special: special,
      tax: tax,
      thumb: thumb ?? "",
      total: null,
      totalSales: salesQty,
      realPrice: realPrice
    );

}

class AttributeGroup {
    AttributeGroup({
        required this.attributeGroupId,
        required this.name,
        required this.attribute,
    });

    final String? attributeGroupId;
    final String? name;
    final List<Attribute> attribute;

    factory AttributeGroup.fromMap(Map<String, dynamic> json){ 
        return AttributeGroup(
            attributeGroupId: json["attribute_group_id"],
            name: json["name"],
            attribute: json["attribute"] == null ? [] : List<Attribute>.from(json["attribute"]!.map((x) => Attribute.fromMap(x))),
        );
    }

}

class Attribute {
    Attribute({
        required this.attributeId,
        required this.name,
        required this.text,
    });

    final String? attributeId;
    final String? name;
    final String? text;

    factory Attribute.fromMap(Map<String, dynamic> json){ 
        return Attribute(
            attributeId: json["attribute_id"],
            name: json["name"],
            text: json["text"],
        );
    }

}

class Breadcrumb {
    Breadcrumb({
        required this.text,
        required this.href,
    });

    final String? text;
    final String? href;

    factory Breadcrumb.fromMap(Map<String, dynamic> json){ 
        return Breadcrumb(
            text: json["text"],
            href: json["href"],
        );
    }

}

class ImageData {
    ImageData({
        required this.thumb,
        required this.popup,
    });

    final String? thumb;
    final String? popup;

    factory ImageData.fromMap(Map<String, dynamic> json){ 
        return ImageData(
            thumb: json["thumb"],
            popup: json["popup"],
        );
    }

}

class Tag {
    Tag({
        required this.tag,
        required this.href,
    });

    final String? tag;
    final String? href;

    factory Tag.fromMap(Map<String, dynamic> json){ 
        return Tag(
            tag: json["tag"],
            href: json["href"],
        );
    }

}

class ListReview {
    ListReview({
        required this.reviewId,
        required this.author,
        required this.rating,
        required this.text,
        required this.productId,
        required this.name,
        required this.price,
        required this.image,
        required this.dateAdded,
        required this.reviewImage,
        required this.image1,
        required this.image2,
        required this.reviewVideo,
        required this.video1,
        required this.video2,
    });

    final String? reviewId;
    final String? author;
    final double? rating;
    final String? text;
    final String? productId;
    final String? name;
    final String? price;
    final String? image;
    final DateTime? dateAdded;
    final String? reviewImage;
    final String? image1;
    final String? image2;
    final String? reviewVideo;
    final String? video1;
    final String? video2;

    factory ListReview.fromMap(Map<String, dynamic> json){ 
        return ListReview(
            reviewId: json["review_id"],
            author: json["author"],
            rating: double.tryParse(json["rating"]?.toString() ?? ""),
            text: json["text"],
            productId: json["product_id"],
            name: json["name"],
            price: json["price"],
            image: json["image"],
            dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
            reviewImage: json["review_image"],
            image1: json["image1"],
            image2: json["image2"],
            reviewVideo: json["review_video"],
            video1: json["video1"],
            video2: json["video2"],
        );
    }

}

class ProductOption {
    ProductOption({
        required this.productOptionId,
        required this.productOptionValue,
        required this.optionId,
        required this.name,
        required this.fix,
        required this.type,
        required this.value,
        required this.required,
    });

    final String? productOptionId;
    final List<ProductOptionValue> productOptionValue;
    final String? optionId;
    final String? name;
    final String? fix;
    final String? type;
    final String? value;
    final String? required;

    factory ProductOption.fromMap(Map<String, dynamic> json){ 
        return ProductOption(
            productOptionId: json["product_option_id"],
            productOptionValue: json["product_option_value"] == null ? [] : List<ProductOptionValue>.from(json["product_option_value"]!.map((x) => ProductOptionValue.fromMap(x))),
            optionId: json["option_id"],
            name: json["name"],
            fix: json["fix"],
            type: json["type"],
            value: json["value"],
            required: json["required"],
        );
    }

}

class ProductOptionValue {
    ProductOptionValue({
        required this.productOptionValueId,
        required this.optionValueId,
        required this.name,
        required this.code,
        required this.image,
        required this.price,
        required this.priceOption,
        required this.pricePrefix,
    });

    final String? productOptionValueId;
    final String? optionValueId;
    final String? name;
    final String? code;
    final dynamic image;
    final bool? price;
    final double? priceOption;
    final String? pricePrefix;

    factory ProductOptionValue.fromMap(Map<String, dynamic> json){ 
        return ProductOptionValue(
            productOptionValueId: json["product_option_value_id"],
            optionValueId: json["option_value_id"],
            name: json["name"],
            code: json["code"],
            image: json["image"],
            price: json['price'],
            priceOption: double.tryParse(json['price_option']?.toString() ?? ""),
            pricePrefix: json["price_prefix"],
        );
    }

}

class StockWarehouse {
    StockWarehouse({
        required this.productOptionValueId,
        required this.optionValueId,
        required this.name,
        required this.code,
        required this.image,
        required this.quantity,
        required this.subtract,
        required this.price,
        required this.pricePrefix,
        required this.weight,
        required this.weightPrefix,
    });

    final String? productOptionValueId;
    final String? optionValueId;
    final String? name;
    final String? code;
    final String? image;
    final String? quantity;
    final String? subtract;
    final String? price;
    final String? pricePrefix;
    final String? weight;
    final String? weightPrefix;

    factory StockWarehouse.fromMap(Map<String, dynamic> json){ 
        return StockWarehouse(
            productOptionValueId: json["product_option_value_id"],
            optionValueId: json["option_value_id"],
            name: json["name"],
            code: json["code"],
            image: json["image"],
            quantity: json["quantity"],
            subtract: json["subtract"],
            price: json["price"],
            pricePrefix: json["price_prefix"],
            weight: json["weight"],
            weightPrefix: json["weight_prefix"],
        );
    }

}