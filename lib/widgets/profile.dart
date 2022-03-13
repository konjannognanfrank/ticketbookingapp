import 'package:flutter/material.dart';
import 'package:myuiapp/provider/profile.dart';
import 'package:myuiapp/widgets/editProfile.dart';
import 'package:provider/provider.dart';

import 'package:unicons/unicons.dart';

import '../models/profile.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white38,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
        title: Text(
          "Account",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text("Edit Profile"),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Consumer<ProfileInfo>(
                      builder: (_, notifier, __) => Image.network(
                        '${notifier.image}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 130,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 9,
                    height: MediaQuery.of(context).size.height / 21,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                        onPressed: () {
                          //TODO: take a picture
                        },
                        icon: Icon(UniconsLine.camera)),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text("Name"),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Consumer<ProfileInfo>(
                  builder: (_, notifier, __) => Text(
                    "${notifier.name}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text("Email"),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Consumer<ProfileInfo>(
                  builder: (_, notifier, __) => Text(
                    "${notifier.email}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text("Tel Number"),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Consumer<ProfileInfo>(
                  builder: (_, notifier, __) => Text(
                    "${notifier.tellNumber}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text("Location"),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Consumer<ProfileInfo>(
                  builder: (_, notifier, __) => Text(
                    "${notifier.location}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
