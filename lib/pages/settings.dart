import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myuiapp/models/profile.dart';
import 'package:myuiapp/widgets/profile.dart';

import 'package:unicons/unicons.dart';
import '../provider/profile.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;
  TextEditingController _seatNumberController = TextEditingController();
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileInfo>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 11,
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
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Consumer<ProfileInfo>(
                      builder: (_, notifier, __) => Text(
                        '${notifier.name}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Consumer<ProfileInfo>(
                      builder: (_, notifier, __) => Text(
                        '${notifier.email}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
              tileColor: Colors.grey[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Icon(Icons.person),
              title: Text('Personal Data'),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp)),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
                tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                leading: Icon(UniconsLine.moon),
                title: Text('Change Theme'),
                trailing: Switch(
                  value: isSwitched,
                  onChanged: toggleSwitch,
                )),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black45,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Icon(
                Icons.more_horiz_rounded,
                color: Colors.blue,
              ),
              title: Text('FAQ'),
              trailing: IconButton(
                  onPressed: () {
                    //TODO: navigate to web blog
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp)),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Icon(
                Icons.people_alt,
                color: Colors.blue,
              ),
              title: Text('Our Comunity'),
              trailing: IconButton(
                  onPressed: () {
                    //TODO: navigate to web blog
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp)),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black45,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                signOut();
                Navigator.of(context).pushNamed('/login-screen');
                Fluttertoast.showToast(
                    msg:
                        'Thank you for using our services, you are welcome to login again');
              },
              tileColor: Colors.grey[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              title: Text('Logout'),
              trailing: IconButton(
                  onPressed: () {
                    //TODO: navigate to web blog
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp)),
            ),
          ],
        ),
      ),
    );
  }
}
