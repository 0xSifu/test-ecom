class ProductFilter {
  final String id;
  final String name;

  ProductFilter({required this.id, required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductFilter &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'ProductFilter(id: $id, name: $name)';
}
