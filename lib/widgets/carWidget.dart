import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

import '../busses/stc.dart';

class CarWidget extends StatelessWidget {
  final String title;
  final String number;
  const CarWidget({
    required this.title,
    required this.number,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/stc-bus',
            arguments: {'busNumber': number, 'title': title});
      },
      child: Column(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
            child: Center(
              child: Icon(
                UniconsLine.bus,
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
