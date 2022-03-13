import 'package:flutter/material.dart';

import 'package:myuiapp/provider/bus.dart';

import 'package:myuiapp/widgets/ticketWidget.dart';
import 'package:provider/provider.dart';

import '../provider/cartProvider.dart';
import '../widgets/badge.dart';

class Stc extends StatelessWidget {
  static const routeName = '/stc-bus';
  Stc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final busNumber =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final title = busNumber['title'];
    final busNum1 = busNumber['busNumber'];
    final busPro = Provider.of<BusProvider>(context)
        .bus
        .firstWhere((busNum) => busNum.busNumber == busNum1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<Cart>(
            builder: (_, notifier, ch) => Badge(
              child: ch!,
              value: notifier.itemCount.toString(),
              color: Colors.red,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart-screen');
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          title!,
          style: TextStyle(color: Colors.black),
        ),
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
      body: ListView.separated(
          itemBuilder: (context, index) => TicketWidget(
                price: busPro.price,
                companyName: busPro.companyName,
                departureDate: DateTime.now().toString(),
                seatNuumber: busPro.numberOfSeats.toString(),
                arivalTime: busPro.arivalTime,
                busNumber: busPro.busNumber,
                departureTime: busPro.departureTime,
                destinationCity: busPro.destinationCity,
                reportingTime: busPro.reportingTime,
                fromCity: busPro.fromCity,
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: 1),
    );
  }
}
