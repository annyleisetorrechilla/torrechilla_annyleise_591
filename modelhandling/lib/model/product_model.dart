class Product {
  final int? id;
  final String name;
  final double price;
  final int quantity;

  Product({this.id, required this.name, required this.price, required this.quantity});

  // From database
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(id: map['id'], name: map['name'], price: map['price'], quantity: map['quantity']);
  }

  // To database
  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'quantity': quantity};
  }
}