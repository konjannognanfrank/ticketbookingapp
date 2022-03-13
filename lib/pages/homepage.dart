import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myuiapp/add_buss/add_buss.dart';
import 'package:myuiapp/provider/bus.dart';
import 'package:myuiapp/provider/cartProvider.dart';

import 'package:provider/provider.dart';

import 'package:unicons/unicons.dart';

import '../widgets/carWidget.dart';

class TicketBookingHomePage extends StatefulWidget {
  @override
  _TicketBookingHomePageState createState() => _TicketBookingHomePageState();
}

class _TicketBookingHomePageState extends State<TicketBookingHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BusProvider busProvider = Provider.of<BusProvider>(context);
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddBus()));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: PageView(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Swiper(
                    itemCount: 4,
                    controller: SwiperController(),
                    pagination: SwiperPagination(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.monetization_on),
                                      Text("400 Points")
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Get Discount Up To",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "30%",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4.8,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                                      "Covid: Our Destination are Open to Travel!",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                        flex: 3,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: busProvider.bus.length,
                          itemBuilder: (context, i) {
                            return Consumer<BusProvider>(
                              builder: (_, notifier, __) => CarWidget(
                                number: notifier.bus[i].busNumber,
                                title: '${notifier.bus[i].companyName}',
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => SizedBox(
                            width: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Upcoming Trip",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Consumer<Cart>(
                                      builder: (_, notifier, __) => Text(
                                        "You have ${notifier.itemCount}  upcomming ticket",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "See All",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.greenAccent),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 4,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Consumer<Cart>(
                                builder: (_, notifier, ch) =>
                                    UpcomingTicketWidget(
                                  companyName:
                                      notifier.items[index]!.companyName,
                                  fromCity: notifier.items[index]!.fromCity,
                                  seatNumber: notifier.items[index]!.seatNumber,
                                  toCity: notifier.items[index]!.toCity,
                                ),
                              );
                            },
                            itemCount: cart.items.length,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rent a bus now",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Recommended busses for you",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 10,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 160,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [],
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class UpcomingTicketWidget extends StatelessWidget {
  const UpcomingTicketWidget({
    required this.companyName,
    required this.fromCity,
    required this.seatNumber,
    required this.toCity,
  });
  final String companyName;
  final int seatNumber;
  final String toCity;
  final String fromCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 1.4,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(9)),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(
                  UniconsLine.bus,
                  color: Colors.orange,
                ),
                Text(
                  companyName,
                  style: TextStyle(color: Colors.orange),
                ),
                Spacer(),
                Text(
                  'Seat No: $seatNumber',
                  style: TextStyle(color: Colors.orange),
                ),
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
                    Text(fromCity,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.greenAccent,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(toCity,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
