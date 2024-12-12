enum ProductTileType {
  /// For best seller
  bestseller,

  /// For super deal
  superDeal,

  /// Make product content have more height
  ///
  /// so the flash sale indicator can be show up in the product tile.
  /// Need [amount] and [amountSold] to show the sold bar
  flashSale,

  /// Default tile
  ///
  /// use this type to make default product list
  normal,
}
