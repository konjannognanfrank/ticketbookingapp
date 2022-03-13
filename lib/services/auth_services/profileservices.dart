import 'package:firebase_database/firebase_database.dart';

class Profile {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
}
