import 'package:flutter/material.dart';
import 'package:ecom_app/model/product_model.dart';
import 'package:ecom_app/widget/product_widget.dart';
import 'package:ecom_app/screens/cart_page.dart';

class CatalogPage extends StatefulWidget {
  final Cart cart;

  const CatalogPage({super.key, required this.cart});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String selectedCategory = 'All';
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    saveProductsToDatabase();
    getProductsFromDatabase();
    filteredProducts = products; // Initially show all products
  }

  void filterProducts(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        filteredProducts = products;
      } else if (category == 'Electronics') {
        filteredProducts = electronics;
      } else if (category == 'Home Appliances') {
        filteredProducts = homeAppliances;
      }
    });
  }

  void addToCart(Product product) {
    setState(() {
      widget.cart.addProduct(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} añadido al carrito'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('ElectroShop'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: widget.cart),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: selectedCategory == 'All',
                  onSelected: (bool selected) {
                    filterProducts('All');
                  },
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle: TextStyle(
                    color: selectedCategory == 'All' ? Colors.black : Colors.white,
                  ),
                ),
                ChoiceChip(
                  label: const Text('Electronics'),
                  selected: selectedCategory == 'Electronics',
                  onSelected: (bool selected) {
                    filterProducts('Electronics');
                  },
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle: TextStyle(
                    color: selectedCategory == 'Electronics' ? Colors.black : Colors.white,
                  ),
                ),
                ChoiceChip(
                  label: const Text('Home Appliances'),
                  selected: selectedCategory == 'Home Appliances',
                  onSelected: (bool selected) {
                    filterProducts('Home Appliances');
                  },
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle: TextStyle(
                    color: selectedCategory == 'Home Appliances' ? Colors.black : Colors.white,
                  ),
                ),
                // Add more ChoiceChips for other categories as needed
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductWidget(
                    product: filteredProducts[index],
                    addToCart: () => addToCart(filteredProducts[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
