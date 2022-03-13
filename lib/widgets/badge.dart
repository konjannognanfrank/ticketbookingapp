import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  Badge(
      {Key? key, required this.child, required this.color, required this.value})
      : super(key: key);
  final Widget child;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color != null ? color : Theme.of(context).primaryColor,
            ),
            constraints: BoxConstraints(minWidth: 16, minHeight: 16),
            child: Center(
              child: Text(
                value,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
