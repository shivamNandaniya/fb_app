import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import '../helper/fbhelper.dart';
import '../var.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> thoughkey = GlobalKey<FormState>();
  TextEditingController thoughcontroller = TextEditingController();

  @override
  initState() {
    super.initState();
    // FireStoreHelper.fireStoreHelper.initDb();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Mark Thought"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  DigitalClock(
                    digitAnimationStyle: Curves.elasticOut,
                    is24HourTimeFormat: false,
                    areaDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    hourMinuteDigitTextStyle: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 80,
                    ),
                    amPmDigitTextStyle: const TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Form(
                      key: thoughkey,
                      child: TextFormField(
                        controller: thoughcontroller,
                        style: const TextStyle(color: Colors.white),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter your though first....";
                          }
                        },
                        onSaved: (val) {
                          setState(() {
                            though = val!;
                          });
                        },
                        decoration: const InputDecoration(
                            label: Text("Enter Your though"),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            )),
                      )),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (thoughkey.currentState!.validate()) {
                        thoughkey.currentState!.save();

                        date = "${dt.day}/${dt.month}/${dt.year}";
                        time = "${dt.hour}:${dt.minute}:${dt.second}";
                        print(date);
                        print(time);

                        FireStoreHelper.fireStoreHelper
                            .insertData(date: date, time: time, though: though);
                        print(date);
                        print(time);
                        print(though);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "Mark My Thought",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
