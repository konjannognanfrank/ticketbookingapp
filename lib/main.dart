import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myuiapp/models/busModel.dart';
import 'package:myuiapp/models/profile.dart';
import 'package:myuiapp/pages/auth/login.dart';
import 'package:myuiapp/pages/bookingDetails/cartScreen.dart';
import 'package:myuiapp/pages/bookingDetails/payment.dart';

import 'package:myuiapp/provider/bus.dart';
import 'package:myuiapp/provider/cartProvider.dart';
import 'package:myuiapp/provider/profile.dart';
import 'package:myuiapp/widgets/bottomNav.dart';
import 'package:myuiapp/widgets/ticketWidget.dart';
import 'package:provider/provider.dart';
import 'busses/stc.dart';

void main() async {
  // These two lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => BusProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(
          create: (_) => Bus(
              busNumber: '',
              price: 0.0,
              companyName: '',
              numberOfSeats: 0,
              driversName: '',
              arivalTime: '',
              departureTime: '',
              destinationCity: '',
              fromCity: '',
              reportingTime: ''),
        ),
        ChangeNotifierProvider(
            create: (_) => ProfileInfo(
                email: '', location: '', name: '', tellNumber: '', image: '')),
        ChangeNotifierProvider(
            create: (_) => CartItem(
                toCity: '',
                fromCity: '',
                quantity: 0,
                seatNumber: 0,
                busNumber: '',
                companyName: '',
                price: 0.0)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.deepPurple,
          ),
          home: Login(),
          routes: {
            '/ticket-widget': (context) => TicketWidget(
                arivalTime: '',
                busNumber: '',
                departureTime: '',
                companyName: '',
                destinationCity: '',
                fromCity: '',
                price: 0.0,
                reportingTime: '',
                departureDate: '',
                seatNuumber: ''),
            '/stc-bus': (context) => Stc(),
            '/login-screen': (context) => Login(),
            '/payment': (context) => Payment(),
            '/cart-screen': (context) => CartScreen(),
            '/bottom-nav': (context) => BottomNav(),
          }),
    );
  }
}
