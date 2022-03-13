import 'busModel.dart';

class Ticket {
  final String ticketId;
  final String departureTime;
  final String reportingTime;
  final String destinationCity;
  final String fromCity;
  final String arivalTime;
  final String busNumber;
  final String seatNumber;

  const Ticket({
    required this.arivalTime,
    required this.departureTime,
    required this.destinationCity,
    required this.fromCity,
    required this.reportingTime,
    required this.ticketId,
    required this.busNumber,
    required this.seatNumber,
  });
}
