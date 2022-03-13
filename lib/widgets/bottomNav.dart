import 'package:flutter/material.dart';
import 'package:myuiapp/pages/homepage.dart';
import 'package:myuiapp/pages/myTicket.dart';
import 'package:myuiapp/pages/notifications.dart';
import 'package:myuiapp/pages/settings.dart';
import 'package:unicons/unicons.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _pageIndex = 0;

  PageController? pageController;
  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController();
  }

  List<Widget> pages = [
    TicketBookingHomePage(),
    Myticket(),
    Notifications(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (idx) {
          setState(() {
            _pageIndex = idx;
          });
          pageController!.jumpToPage(idx);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.bus), label: "All Buses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), label: "Notification"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: "Settings"),
        ],
      ),
      body: pages.elementAt(_pageIndex),
    );
  }
}
