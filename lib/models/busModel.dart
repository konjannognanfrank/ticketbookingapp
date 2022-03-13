import 'package:flutter/material.dart';

class Bus with ChangeNotifier {
  final String busNumber; //
  final String companyName; //
  final int numberOfSeats; //
  final String driversName; //
  final String departureTime;
  final double price;
  final String reportingTime;
  final String destinationCity;
  final String fromCity;
  final String arivalTime;

  Bus({
    required this.busNumber,
    required this.price,
    required this.companyName,
    required this.numberOfSeats,
    required this.driversName,
    required this.arivalTime,
    required this.departureTime,
    required this.destinationCity,
    required this.fromCity,
    required this.reportingTime,
  });
}
