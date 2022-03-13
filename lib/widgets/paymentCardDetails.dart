import 'package:flutter/material.dart';

class PaymentCardWidget extends StatelessWidget {
  PaymentCardWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 15,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
          child: Form(
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
                  style: TextStyle(fontSize: 20, color: Colors.black54),
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
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Card Number',
                      suffixIcon: Icon(Icons.payment)),
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
                        style: TextStyle(fontSize: 20, color: Colors.black54),
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
                            return 'This field is required please';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                        style: TextStyle(fontSize: 20, color: Colors.black54),
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
        ),
      ],
    );
  }
}
