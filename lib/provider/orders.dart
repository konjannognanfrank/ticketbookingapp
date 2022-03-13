import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'cartProvider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> buses;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.buses,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    //Todo change api
    final url = Uri.parse(
        'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/orders');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          buses: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  toCity: item['toCity'],
                  seatNumber: item['seatNumber'],
                  fromCity: item['fromCity'],
                  busNumber: item['busNumber'],
                  price: item['price'],
                  quantity: item['quantity'],
                  companyName: item['companyName'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    //Todo change api
    final url = Uri.parse(
        'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/orders');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.busNumber,
                  'title': cp.companyName,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        buses: cartProducts,
      ),
    );
    notifyListeners();
  }
}
