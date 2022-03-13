import 'package:flutter/material.dart';
import 'package:myuiapp/pages/myTicket.dart';
import 'package:myuiapp/provider/cartProvider.dart' show Cart;
import 'package:myuiapp/widgets/cartItem.dart';
import 'package:provider/provider.dart';

import '../../provider/orders.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  static final routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('my ticket'),
        backgroundColor: Color(0xFFF27e85b),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Text("😷"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Covid: We strictly adhere to the Covid-19 rules!",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text('GHc${cart.totalAmount.toStringAsFixed(2)}'),
                    ),
                    OrderButton(cart: cart)
                  ]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, i) => CartItemWidget(
                  busNumber: cart.items.values.toList()[i].busNumber,
                  companyName: cart.items.values.toList()[i].companyName,
                  id: cart.items.keys.toList()[i],
                  price: cart.items.values.toList()[i].price,
                  quantity: cart.items.values.toList()[i].quantity),
            ),
          ),
        ],
      ),
      // body: ListView.builder(
      //   shrinkWrap: true,
      //   itemBuilder: (context, i) => ListTile(
      //     leading: CircleAvatar(
      //       child: Text('${buspro1.companyName}'),
      //     ),
      //     title: Text('${buspro1.busNumber}'),
      //     subtitle: Text(
      //       '${buspro1.seatNumber}',
      //       style: TextStyle(color: Colors.green),
      //     ),
      //     trailing: Text('${buspro1.price.toStringAsFixed(2)}',
      //         style: TextStyle(backgroundColor: Colors.orange)),
      //   ),
      //   itemCount: buspro.items.length,
      // ),
    );
  }
}

class OrderButton extends StatefulWidget {
  OrderButton({Key? key, required this.cart}) : super(key: key);
  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: isLoading ? CircularProgressIndicator() : Text('Book now'),
        onPressed: (widget.cart.totalAmount <= 0 || isLoading)
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.items.values.toList(), widget.cart.totalAmount);
                setState(() {
                  isLoading = false;
                });
                widget.cart.dispose();
              });
  }
}
