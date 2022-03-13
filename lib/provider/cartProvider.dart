import 'dart:core';

import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String busNumber;
  final String fromCity;
  final String toCity;
  final String companyName; //
  int quantity = 0;
  final int seatNumber;
  final double price;

  CartItem({
    required this.toCity,
    required this.fromCity,
    required this.quantity,
    required this.seatNumber,
    required this.busNumber,
    required this.companyName,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String busNumber,
    double price,
    String companyName,
    int seatNumber,
    String fromCity,
    String toCity,
  ) {
    if (_items.containsKey(busNumber)) {
      _items.update(
          busNumber,
          (existingCar) => CartItem(
                toCity: existingCar.toCity,
                fromCity: existingCar.fromCity,
                quantity: existingCar.quantity + 1,
                seatNumber: existingCar.seatNumber,
                busNumber: existingCar.busNumber,
                companyName: existingCar.companyName,
                price: existingCar.price,
              ));
    } else {
      _items.putIfAbsent(
          busNumber,
          () => CartItem(
              quantity: 1,
              seatNumber: seatNumber,
              busNumber: busNumber,
              companyName: companyName,
              toCity: toCity,
              fromCity: fromCity,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String busNumber) {
    _items.remove(busNumber);
    notifyListeners();
  }
}
