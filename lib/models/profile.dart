import 'package:flutter/material.dart';

class ProfileInfo with ChangeNotifier {
  final String name;
  final String email;
  final String tellNumber;
  final String location;
  final String image;

  ProfileInfo({
    required this.image,
    required this.email,
    required this.location,
    required this.name,
    required this.tellNumber,
  });
}
