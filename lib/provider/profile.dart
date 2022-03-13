import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myuiapp/widgets/profile.dart';
import 'package:http/http.dart' as http;
import '../models/profile.dart';
import 'dart:convert';

class ProfileProvider with ChangeNotifier {
  List<ProfileInfo> _profile = [];

  List<ProfileInfo> get profile {
    return [..._profile];
  }

  Future<void> retrieveData() async {
    var url = Uri.parse(
        'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/user');
    final response = await http.get(url);
    final List<ProfileInfo> loadedProfile = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((profileId, profileData) {
      loadedProfile.add(ProfileInfo(
          email: profileData['email'],
          location: profileData['location'],
          name: profileData['name'],
          tellNumber: profileData['tellNumber'],
          image: profileData['image']));
    });
    _profile = loadedProfile.reversed.toList();
    notifyListeners();
  }

  Future<void> addProfile(ProfileInfo profile) async {
    var url = Uri.parse(
        'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/user');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': profile.email,
            'location': profile.location,
            'name': profile.name,
            'telNumber': profile.tellNumber,
            'image': profile.image
          }));
      final newProfile = ProfileInfo(
        image: profile.image,
        email: profile.email,
        location: profile.location,
        name: profile.name,
        tellNumber: profile.tellNumber,
      );
      _profile.add(newProfile);
      notifyListeners();
    } catch (error) {
      throw error;
      print(error);
    }
  }

  Future<void> updateProfile(String id, ProfileInfo newProfile) async {
    final proIndex = _profile.indexWhere((element) => element.email == id);
    if (proIndex >= 0) {
      final url = Uri.parse(
          'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/user');
      await http.patch(url,
          body: json.encode({
            'email': newProfile.email,
            'location': newProfile.location,
            'name': newProfile.name,
            'tellNumber': newProfile.tellNumber,
            'image': newProfile.image
          }));
      _profile[proIndex] = newProfile;
      notifyListeners();
    } else {
      print('No Profile to update');
    }
  }

  Future<void> deleteProfile(index) async {
    final url = Uri.parse(
        'https://ticket-booking-app-4e9dc-default-rtdb.firebaseio.com/user');
    final removeProfile =
        _profile.removeWhere((element) => element.name == profile[index].name);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      throw HttpException('Could not delete profile');
      notifyListeners();
    }
  }
}
