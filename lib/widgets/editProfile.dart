import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myuiapp/models/profile.dart';
import 'package:myuiapp/provider/profile.dart';
import 'package:myuiapp/services/auth_services/profileservices.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  var _profile =
      ProfileInfo(email: "", location: "", name: "", tellNumber: "", image: '');
  final _formKey = GlobalKey<FormState>();
  PickedFile? imageFile;

  Future<void> saveData() async {
    final isValidate = _formKey.currentState!.validate();
    if (!isValidate) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<ProfileProvider>(context, listen: false).addProfile(_profile);

    setState(() {
      isLoading = true;
    });
    _nameController.clear();
    _numberController.clear();
    _locationController.clear();

    isLoading = false;
  }

  // Future<void> _openGallery(BuildContext context) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   setState(() {
  //     imageFile = pickedFile! as PickedFile?;
  //   });

  //   Navigator.pop(context);
  // }
  File? _image;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _openCamera(BuildContext context) async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openImagePicker();
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (value) {
                              _profile = ProfileInfo(
                                  email: _profile.email,
                                  location: _profile.location,
                                  name: value!,
                                  tellNumber: _profile.tellNumber,
                                  image: _profile.image);
                            },
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _profile = ProfileInfo(
                                  email: _profile.email,
                                  location: _profile.location,
                                  name: _profile.name,
                                  tellNumber: value!,
                                  image: _profile.image);
                            },
                            controller: _numberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Telephone',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _profile = ProfileInfo(
                                  email: _profile.email,
                                  location: value!,
                                  name: _profile.name,
                                  tellNumber: _profile.tellNumber,
                                  image: _profile.image);
                            },
                            controller: _locationController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Location',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: _image != null
                                    ? Image.file(_image!, fit: BoxFit.cover)
                                    : const Text('Please select an image'),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _showChoiceDialog(context);
                                    },
                                    child: Text("Choose picture"),
                                  ),
                                ],
                              ),
                              // Expanded(
                              //   child: TextFormField(
                              //     decoration: InputDecoration(
                              //       labelText: 'Select Image',
                              //     ),
                              //     textInputAction: TextInputAction.done,
                              //     controller: _imageController,
                              //     validator: (value) {
                              //       if (value!.isEmpty) {
                              //         return 'This field cant be empty';
                              //       } else {
                              //         return null;
                              //       }
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              saveData();
                              print('its saved');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 17,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
    );
  }
}
