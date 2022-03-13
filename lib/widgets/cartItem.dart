import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cartProvider.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget(
      {Key? key,
      required this.busNumber,
      required this.companyName,
      required this.id,
      required this.price,
      required this.quantity})
      : super(key: key);
  final String id;
  final String busNumber;
  final String companyName;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 20,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text(
                        'Do you want to remove the ticket from your cart?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('No')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Yes')),
                    ],
                  ));
        },
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(busNumber);
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(child: Text('GHc$price')),
                ),
              ),
              title: Text(busNumber),
              subtitle: Text(companyName),
              trailing: Text('Total: GHC${(price * quantity)}'),
            ),
          ),
        ));
  }
}
