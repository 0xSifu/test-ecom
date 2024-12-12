class Product {
  Product({
    required this.id,
    this.thumbnail,
    this.images,
    required this.title,
    required this.price,
    required this.url,
    this.description,
    this.priceOriginal = 0,
    this.amount,
    this.amountSold,
    this.top,
    this.soldPerMonth,
    this.rating,
    this.code,
    this.rewardPoints,
  });

  /// product id
  final int id;

  /// thumbnail image
  final String? thumbnail;

  /// image
  final List<String>? images;

  /// product title
  final String title;

  // description
  final String? description;

  /// price
  final int price;

  /// original price
  final int priceOriginal;

  /// total product
  final int? amount;

  /// total product sold
  final int? amountSold;

  /// url
  String url;

  /// Top bestseller
  final int? top;

  /// Sold per month
  final int? soldPerMonth;

  /// rating
  final double? rating;

  /// code
  String? code;

  /// reward points
  int? rewardPoints;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      thumbnail: json['thumbnail'],
      images: json['images'],
      title: json['title'],
      price: json['price'],
      url: json['url'],
    );
  }
}
