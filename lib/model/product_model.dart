import 'dart:math';
import 'package:ecom_app/sqflite/bbdd.dart';
import 'package:sqflite/sqflite.dart'; // Importa DatabaseService

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Método para convertir Product a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

List<Product> products = [
  ...electronics,
  ...homeAppliances,
];

Future<void> saveProductsToDatabase() async {
  final dbService = DatabaseService();
  for (var product in products) {
    try {
      await dbService.insertProduct(product.toMap());
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        await dbService.updateProduct(product.toMap());
      } else {
        rethrow;
      }
    }
  }
}

Future<List<Product>> getProductsFromDatabase() async {
  final dbService = DatabaseService();
  List<Map<String, dynamic>> productsMap = await dbService.getProducts();
  return productsMap.map((productMap) => Product(
    id: productMap['id'],
    name: productMap['name'],
    description: productMap['description'],
    price: productMap['price'],
    imageUrl: productMap['imageUrl'],
  )).toList();
}

List<Product> electronics = [
  Product(
    id: 11,
    name: 'Smartphone',
    description: 'Latest model smartphone with high-end features',
    price: 999.99,
    imageUrl: 'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
  ),
  Product(
    id: 12,
    name: 'Laptop',
    description: 'High performance laptop for gaming and work',
    price: 1499.99,
    imageUrl: 'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
  ),
  Product(
    id: 13,
    name: 'Smartwatch',
    description: 'Wearable smartwatch with fitness tracking',
    price: 199.99,
    imageUrl: 'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
  ),
];

List<Product> homeAppliances = [
  Product(
    id: 14,
    name: 'Refrigerator',
    description: 'Energy efficient refrigerator with large capacity',
    price: 799.99,
    imageUrl: 'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
  ),
  Product(
    id: 15,
    name: 'Washing Machine',
    description: 'Top load washing machine with smart features',
    price: 499.99,
    imageUrl: 'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
  ),
  Product(
    id: 16,
    name: 'Microwave Oven',
    description: 'Compact microwave oven with multiple settings',
    price: 99.99,
    imageUrl: 'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
  ),
];