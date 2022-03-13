import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../provider/bus.dart';

class Tick extends StatelessWidget {
  const Tick({
    required this.arivalTime,
    required this.busNumber,
    required this.companyName,
    required this.departureTime,
    required this.destinationCity,
    required this.fromCity,
    required this.numberOfSeats,
    required this.reportingTime,
    Key? key,
  }) : super(key: key);
  final String companyName;
  final String numberOfSeats;
  final String fromCity;
  final String reportingTime;
  final String departureTime;
  final String busNumber;
  final String destinationCity;
  final String arivalTime;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/stc-bus',
              arguments: {'busNumber': busNumber, 'title': companyName});
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(9)),
          padding: EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/ticket-widget');
            },
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
                    Consumer<BusProvider>(
                      builder: (_, notifier, __) => Text(
                        "${companyName} Bus",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                    Spacer(),
                    Consumer<BusProvider>(
                        builder: (_, notifier, __) => Text(
                              "Seat: ${numberOfSeats}",
                              style: TextStyle(color: Colors.orange),
                            )),
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
                        Consumer<BusProvider>(
                          builder: (_, notifier, __) => Text(
                            fromCity,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Consumer<BusProvider>(
                            builder: (_, notifier, __) => Text(
                              "Reporting Time: ${reportingTime}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Consumer<BusProvider>(
                            builder: (_, notifier, __) => Text(
                              "Departure Time: ${departureTime}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Consumer<BusProvider>(
                            builder: (_, notifier, __) => Text(
                              "Bus Number: ${busNumber}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
                        Consumer<BusProvider>(
                          builder: (_, notifier, __) => Text(
                            destinationCity,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Consumer<BusProvider>(
                            builder: (_, notifier, __) => Text(
                              arivalTime,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "February 11, 2022",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
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
