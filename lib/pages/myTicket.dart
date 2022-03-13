import 'package:flutter/material.dart';
import 'package:myuiapp/provider/bus.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../models/busModel.dart';
import '../widgets/TickTicketWidget.dart';

class Myticket extends StatelessWidget {
  const Myticket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final bus = Provider.of<Bus>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(
          "My Tickets",
          style: TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Search",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            )),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Consumer<BusProvider>(
          builder: (_, notifier, __) => Tick(
              arivalTime: notifier.bus[index].arivalTime,
              busNumber: notifier.bus[index].busNumber,
              companyName: notifier.bus[index].companyName,
              departureTime: notifier.bus[index].departureTime,
              destinationCity: notifier.bus[index].destinationCity,
              fromCity: notifier.bus[index].fromCity,
              numberOfSeats: notifier.bus[index].numberOfSeats.toString(),
              reportingTime: notifier.bus[index].reportingTime),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: busProvider.bus.length,
      ),
    );
  }
}
