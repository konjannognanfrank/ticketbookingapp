import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/busModel.dart';

class BusProvider with ChangeNotifier {
  BusProvider();
  List<Bus> _bus = [
    Bus(
        busNumber: 'as4563',
        price: 70,
        companyName: 'VIP',
        numberOfSeats: 80,
        driversName: 'Mr kofi ajee',
        arivalTime: '3:30pm',
        departureTime: '',
        destinationCity: 'KUMASI',
        fromCity: 'WALEWALE',
        reportingTime: '2:30'),
    Bus(
        busNumber: 'NR-123-22',
        price: 80,
        companyName: 'STC',
        numberOfSeats: 50,
        driversName: 'Mr Aboakye',
        arivalTime: '2:30pm',
        departureTime: '3:30',
        destinationCity: 'Accra',
        fromCity: 'WALEWALE',
        reportingTime: '2:30')
  ];

  List<Bus> get bus {
    return [..._bus];
  }

  Iterable<Bus> findByNum(String number) {
    return _bus.where((element) => element.busNumber == number);
  }

  Future<void> addBus(Bus bus) async {
    final url = Uri.parse(
        'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/vehicles.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'busNumber': bus.busNumber,
            'price': bus.price,
            'companyName': bus.companyName,
            'numberOfSeats': bus.numberOfSeats,
            'driversName': bus.driversName,
            'arivalTime': bus.arivalTime,
            'departureTime': bus.departureTime,
            'destinationCity': bus.destinationCity,
            'fromCity': bus.fromCity,
            'reportingTime': bus.reportingTime
          }));
      final newBus = Bus(
          busNumber: bus.busNumber,
          price: bus.price,
          companyName: bus.companyName,
          numberOfSeats: bus.numberOfSeats,
          driversName: bus.driversName,
          arivalTime: bus.arivalTime,
          departureTime: bus.departureTime,
          destinationCity: bus.destinationCity,
          fromCity: bus.fromCity,
          reportingTime: bus.reportingTime);
      _bus.add(newBus);
      notifyListeners();
    } catch (e) {
      throw e;
      print(e);
    }
  }

  Future<void> deleteBus(index) async {
    final url = Uri.parse(
        'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/vehicles.json');
    final existingCar = _bus.indexWhere((car) => car.busNumber == index);
    Bus? existingBus = _bus[existingCar];
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _bus.insert(existingCar, existingBus);
      notifyListeners();
      throw HttpException('Could not delete bus data');
    }
    existingBus = null;
  }

  Future<void> fetchBus([bool filterBusOwner = false]) async {
    final filtering = filterBusOwner ? 'OrderBy="creatorId"' : '';
    var url = Uri.parse(
        'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/vehicles.json?auth=$filtering');
    try {
      final response = await http.get(url);
      final extractionData = json.decode(response.body) as Map<String, dynamic>;
      if (extractionData == null) {
        return;
      }
      final List<Bus> loadedBus = [];
      extractionData.forEach((busNumber, carData) {
        loadedBus.add(Bus(
            busNumber: busNumber,
            price: carData['price'],
            companyName: carData['companyName'],
            numberOfSeats: carData['numberOfSeats'],
            driversName: carData['driversName'],
            arivalTime: carData['arivalTime'],
            departureTime: carData['departureTime'],
            destinationCity: carData['destinationCity'],
            fromCity: carData['fromCity'],
            reportingTime: carData['reportingTime']));
      });
      _bus = loadedBus;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }
}
