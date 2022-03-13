import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myuiapp/models/busModel.dart';
import 'package:provider/provider.dart';

import '../provider/bus.dart';
import 'package:intl/intl.dart';

class AddBus extends StatefulWidget {
  AddBus({Key? key}) : super(key: key);

  @override
  State<AddBus> createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
  TextEditingController _driverNameController = TextEditingController();

  TextEditingController _caompanyNameController = TextEditingController();

  TextEditingController _busNumberController = TextEditingController();

  TextEditingController _numberOfSeatsController = TextEditingController();

  TextEditingController _priceTicketController = TextEditingController();
  TextEditingController _departureNameController = TextEditingController();

  TextEditingController _reportingController = TextEditingController();

  TextEditingController _destinationController = TextEditingController();

  TextEditingController _fromController = TextEditingController();
  TextEditingController _arrivalController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedValue = "STC";
  var _busData = Bus(
      busNumber: '',
      price: 0.0,
      companyName: '',
      numberOfSeats: 0,
      driversName: '',
      arivalTime: '',
      departureTime: '',
      destinationCity: '',
      fromCity: '',
      reportingTime: '');
  Future<void> addBus() async {
    final isValidate = _formKey.currentState!.validate();
    if (isValidate) {
      return;
    }
    _formKey.currentState!.save();
    //Todo save bus Details here
    await Provider.of<BusProvider>(context).addBus(Bus(
        departureTime: _departureNameController.text,
        price: double.parse(_priceTicketController.text),
        fromCity: _fromController.text,
        destinationCity: _destinationController.text,
        arivalTime: _arrivalController.text,
        reportingTime: _reportingController.text.toString(),
        busNumber: _busNumberController.text,
        companyName: _caompanyNameController.text,
        numberOfSeats: _numberOfSeatsController.text as int,
        driversName: _driverNameController.text));
  }

  @override
  Widget build(BuildContext context) {
    BusProvider busProvider = Provider.of<BusProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF27e85b),
        title: Text("Add Buss"),
      ),
      body: ListView(
        children: [
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _busData = Bus(
                              busNumber: _busData.busNumber,
                              price: _busData.price,
                              companyName: _busData.companyName,
                              numberOfSeats: _busData.numberOfSeats,
                              driversName: value!,
                              arivalTime: _busData.arivalTime,
                              departureTime: _busData.departureTime,
                              destinationCity: _busData.destinationCity,
                              fromCity: _busData.fromCity,
                              reportingTime: _busData.reportingTime);
                        },
                        textInputAction: TextInputAction.next,
                        controller: _driverNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Color.fromRGBO(100, 0, 100, 10),
                          hintText: "Drivers Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please this field is required';
                          }
                          return null;
                        },
                      ),
                      Container(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _busData = Bus(
                              busNumber: _busData.busNumber,
                              price: _busData.price,
                              companyName: value!,
                              numberOfSeats: _busData.numberOfSeats,
                              driversName: _busData.driversName,
                              arivalTime: _busData.arivalTime,
                              departureTime: _busData.departureTime,
                              destinationCity: _busData.destinationCity,
                              fromCity: _busData.fromCity,
                              reportingTime: _busData.reportingTime);
                        },
                        controller: _caompanyNameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Color.fromRGBO(100, 0, 100, 10),
                          hintText: "Company Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please this field is required';
                          }
                          return null;
                        },
                      ),
                      Container(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _busData = Bus(
                              busNumber: value!,
                              price: _busData.price,
                              companyName: _busData.companyName,
                              numberOfSeats: _busData.numberOfSeats,
                              driversName: _busData.driversName,
                              arivalTime: _busData.arivalTime,
                              departureTime: _busData.departureTime,
                              destinationCity: _busData.destinationCity,
                              fromCity: _busData.fromCity,
                              reportingTime: _busData.reportingTime);
                        },
                        controller: _busNumberController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Color.fromRGBO(100, 0, 100, 10),
                          hintText: "Bus Registration Number",
                        ),
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please this field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _busData = Bus(
                              busNumber: _busData.busNumber,
                              price: _busData.price,
                              companyName: _busData.companyName,
                              numberOfSeats: int.parse(value!),
                              driversName: _busData.driversName,
                              arivalTime: _busData.arivalTime,
                              departureTime: _busData.departureTime,
                              destinationCity: _busData.destinationCity,
                              fromCity: _busData.fromCity,
                              reportingTime: _busData.reportingTime);
                        },
                        controller: _numberOfSeatsController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Color.fromRGBO(100, 0, 100, 10),
                          hintText: "Number of seats",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please this field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _busData = Bus(
                              busNumber: _busData.busNumber,
                              price: double.parse(value!),
                              companyName: _busData.companyName,
                              numberOfSeats: _busData.numberOfSeats,
                              driversName: _busData.driversName,
                              arivalTime: _busData.arivalTime,
                              departureTime: _busData.departureTime,
                              destinationCity: _busData.destinationCity,
                              fromCity: _busData.fromCity,
                              reportingTime: _busData.reportingTime);
                        },
                        controller: _priceTicketController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Color.fromRGBO(100, 0, 100, 10),
                          hintText: "Price per Ticket",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please this field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onSaved: (value) {
                                _busData = Bus(
                                    busNumber: _busData.busNumber,
                                    price: _busData.price,
                                    companyName: _busData.companyName,
                                    numberOfSeats: _busData.numberOfSeats,
                                    driversName: _busData.driversName,
                                    arivalTime: _busData.arivalTime,
                                    departureTime: value!,
                                    destinationCity: _busData.destinationCity,
                                    fromCity: _busData.fromCity,
                                    reportingTime: _busData.reportingTime);
                              },
                              controller:
                                  _departureNameController, //editing controller of this TextField
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon:
                                      Icon(Icons.timer), //icon of text field
                                  labelText:
                                      "Enter Departure Time" //label text of field
                                  ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  print(pickedTime
                                      .format(context)); //output 10:51 PM
                                  DateTime parsedTime = DateFormat.jm().parse(
                                      pickedTime.format(context).toString());
                                  //converting to DateTime so that we can further format on different pattern.
                                  print(
                                      parsedTime); //output 1970-01-01 22:53:00.000
                                  String formattedTime =
                                      DateFormat('HH:mm:ss').format(parsedTime);
                                  print(formattedTime); //output 14:59:00
                                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                                  setState(() {
                                    _departureNameController.text =
                                        formattedTime; //set the value of text field.
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              onSaved: (value) {
                                _busData = Bus(
                                    busNumber: _busData.busNumber,
                                    price: _busData.price,
                                    companyName: _busData.companyName,
                                    numberOfSeats: _busData.numberOfSeats,
                                    driversName: _busData.driversName,
                                    arivalTime: value!,
                                    departureTime: _busData.departureTime,
                                    destinationCity: _busData.destinationCity,
                                    fromCity: _busData.fromCity,
                                    reportingTime: _busData.reportingTime);
                              },
                              controller:
                                  _arrivalController, //editing controller of this TextField
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon:
                                      Icon(Icons.timer), //icon of text field
                                  labelText:
                                      "Enter Arrival Time" //label text of field
                                  ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  print(pickedTime
                                      .format(context)); //output 10:51 PM
                                  DateTime parsedTime = DateFormat.jm().parse(
                                      pickedTime.format(context).toString());
                                  //converting to DateTime so that we can further format on different pattern.
                                  print(
                                      parsedTime); //output 1970-01-01 22:53:00.000
                                  String formattedTime =
                                      DateFormat('HH:mm:ss').format(parsedTime);
                                  print(formattedTime); //output 14:59:00
                                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                                  setState(() {
                                    _arrivalController.text =
                                        formattedTime; //set the value of text field.
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onSaved: (value) {
                                _busData = Bus(
                                    busNumber: _busData.busNumber,
                                    price: _busData.price,
                                    companyName: _busData.companyName,
                                    numberOfSeats: _busData.numberOfSeats,
                                    driversName: _busData.driversName,
                                    arivalTime: _busData.arivalTime,
                                    departureTime: _busData.departureTime,
                                    destinationCity: _busData.destinationCity,
                                    fromCity: value!,
                                    reportingTime: _busData.reportingTime);
                              },
                              controller: _fromController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: Color.fromRGBO(100, 0, 100, 10),
                                hintText: "From",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please this field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              onSaved: (value) {
                                _busData = Bus(
                                    busNumber: _busData.busNumber,
                                    price: _busData.price,
                                    companyName: _busData.companyName,
                                    numberOfSeats: _busData.numberOfSeats,
                                    driversName: _busData.driversName,
                                    arivalTime: _busData.arivalTime,
                                    departureTime: _busData.departureTime,
                                    destinationCity: _busData.destinationCity,
                                    fromCity: value!,
                                    reportingTime: _busData.reportingTime);
                              },
                              controller: _destinationController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: Color.fromRGBO(100, 0, 100, 10),
                                hintText: "To",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please this field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _busData = Bus(
                              busNumber: _busData.busNumber,
                              price: _busData.price,
                              companyName: _busData.companyName,
                              numberOfSeats: _busData.numberOfSeats,
                              driversName: _busData.driversName,
                              arivalTime: _busData.arivalTime,
                              departureTime: _busData.departureTime,
                              destinationCity: _busData.destinationCity,
                              fromCity: _busData.fromCity,
                              reportingTime: value!);
                        },
                        controller:
                            _reportingController, //editing controller of this TextField
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.timer), //icon of text field
                            labelText: "Enter Time" //label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              _reportingController.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          addBus();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 15,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Save Bus",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
