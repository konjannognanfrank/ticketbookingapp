import 'package:flutter/material.dart';

import '../models/ticketModel.dart';

class TicketProvider with ChangeNotifier {
  List<Ticket> _ticket = [];
  notifyListeners();
}
