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
        backgroundColor: Color(0xFFF27e85b),
        title: Text(
          "My Tickets",
          style: TextStyle(color: Colors.white),
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
