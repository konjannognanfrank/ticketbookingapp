import 'package:flutter/material.dart';
import 'package:myuiapp/provider/bus.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../models/busModel.dart';

import '../provider/cartProvider.dart';

class TicketWidget extends StatefulWidget {
  static final routeName = '/ticket-widget';
  TicketWidget({
    required this.arivalTime,
    required this.busNumber,
    required this.departureTime,
    required this.companyName,
    required this.destinationCity,
    required this.fromCity,
    required this.price,
    required this.reportingTime,
    required this.departureDate,
    required this.seatNuumber,
    Key? key,
  }) : super(key: key);
  final String reportingTime;
  final double price;
  final String departureDate;
  final String departureTime;
  final String companyName;
  final String destinationCity;
  final String fromCity;
  final String arivalTime;
  final String busNumber;
  String seatNuumber;

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  TextEditingController _seatNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  set seatNuumber(String seatNuumber) {}

  void _saveform() {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final busCart = Provider.of<Bus>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final seat = Provider.of<CartItem>(context);
    final busData = Provider.of<BusProvider>(context);
    final bus = busData.bus;
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed('BookBus');
      },
      child: Expanded(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          margin: EdgeInsets.only(right: 10, left: 10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(9)),
          padding: EdgeInsets.all(12),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      UniconsLine.bus,
                      color: Colors.orange,
                    ),
                    Text(
                      widget.companyName,
                      style: TextStyle(color: Colors.orange),
                    ),
                    Spacer(),
                    Text(
                      "${widget.seatNuumber}",
                      style: TextStyle(color: Colors.orange),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fromCity,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "Reporting Time: ${widget.reportingTime}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "Departure Time: ${widget.departureTime}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "Bus No: ${widget.busNumber}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "February 10, 2022",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.greenAccent,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.destinationCity,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            widget.arivalTime,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "February 11, 2022",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          cart.addItem(
                              busCart.busNumber,
                              busCart.price,
                              busCart.companyName,
                              busCart.numberOfSeats,
                              busCart.fromCity,
                              busCart.destinationCity);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Ticket Added to Cart',
                            ),
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  cart.removeItem(busCart.busNumber);
                                }),
                          ));
                        },
                        icon: Icon(Icons.add)),
                    Text('Ghc ${widget.price}'),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 50),
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 10,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              onSaved: (value) {
                                seatNuumber = value!;
                              },
                              controller: _seatNumberController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a seat number';
                                }
                                if (int.parse(value) < busCart.numberOfSeats) {
                                  return 'please the seat is out of range';
                                }
                                if (int.parse(value) == seat.seatNumber) {
                                  return 'Seat is already booked, please select another seat';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Text('Seat Number'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
