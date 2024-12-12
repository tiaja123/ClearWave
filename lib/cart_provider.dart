import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => _cartItems;

  void addItem(String id, String name, String price, String imagePath) {
    if (_cartItems.containsKey(id)) {
      _cartItems.update(
        id,
        (existingItem) => CartItem(
          id: existingItem.id,
          name: existingItem.name,
          price: existingItem.price,
          imagePath: existingItem.imagePath,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          name: name,
          price: price,
          imagePath: imagePath,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class CartItem {
  final String id;
  final String name;
  final String price;
  final String imagePath;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.quantity,
  });
}