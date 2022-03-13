import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  Payment({Key? key}) : super(key: key);
  static final routeName = '/Payment';

  @override
  State<Payment> createState() => _PaymentState();
}

enum Paymen { cardPayment, mobilePayment }

class _PaymentState extends State<Payment> {
  bool visibilityTag = false;
  bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag") {
        visibilityTag = visibility;
      }
      if (field == "obs") {
        visibilityObs = visibility;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  Paymen _payment = Paymen.cardPayment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: Text(
          "Payment Options",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.help_outline_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Text(
                "Please rate your experience. This will help us continually improve our services",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "SELECT A PAYMENT METHOD",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  ListTile(
                    leading: Radio(
                        value: Paymen.cardPayment,
                        groupValue: _payment,
                        onChanged: (Paymen? value) {
                          visibilityObs ? null : _changed(true, "obs");
                          setState(() {
                            _payment = value!;
                          });
                        }),
                    title: Text("Credit / Debit Card"),
                    trailing: IconButton(
                        onPressed: () {
                          visibilityObs ? null : _changed(true, "obs");
                        },
                        icon: Icon(Icons.arrow_drop_down)),
                  ),
                  Divider(
                    color: Colors.brown,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Radio(
                        value: Paymen.mobilePayment,
                        groupValue: _payment,
                        onChanged: (Paymen? value) {
                          visibilityObs ? null : _changed(true, "tag");
                          setState(() {
                            _payment = value!;
                          });
                        }),
                    title: Text("MoMo"),
                    trailing: IconButton(
                        onPressed: () {
                          visibilityObs ? null : _changed(true, "tag");
                        },
                        icon: Icon(Icons.arrow_drop_down)),
                  ),
                ],
              ),
              visibilityObs
                  ? Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'name is required please';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Card Holders Name',
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Card number is required please';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Name',
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {},
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Expiry Date',
                                          suffixIcon: Icon(Icons.payment)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {},
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'CVC',
                                          suffixIcon: Icon(Icons.payment)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
              visibilityTag
                  ? Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mobile Number is required';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Mobile Number',
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please your name is required';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Name',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Confirm Payment',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
