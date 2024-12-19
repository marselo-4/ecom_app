import 'package:ecom_app/screens/cart_page.dart';
import 'package:ecom_app/screens/catalog_page.dart';
import 'package:ecom_app/screens/product_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecom App',
      initialRoute: '/',
      routes: {
        '/': (context) => CatalogPage(cart: Cart(),),
        '/product': (context) => ProductPage(),
        '/cart': (context) => CartPage(cart: Cart())
      },
    );
  }
}
