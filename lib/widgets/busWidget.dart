import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class BusToWidget extends StatelessWidget {
  const BusToWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      margin: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(9)),
      padding: EdgeInsets.all(12),
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
              Text(
                "STC First Bus",
                style: TextStyle(color: Colors.orange),
              ),
              Spacer(),
              Text(
                "Seat 58",
                style: TextStyle(color: Colors.orange),
              )
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
                  Text(
                    "Walewale",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "Reporting Time: 02:18PM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "Departure Time: 03:18PM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "Bus Number: AS-1234-20",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
                  Text(
                    "Kumasi",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "02:40AM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
    );
  }
}
