import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project/global.dart';
import 'package:http/http.dart' as http;
import 'package:project/model/patient.dart';
import 'package:project/view/home_screen.dart';
import 'package:uuid/uuid.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({super.key});

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  String departmentValue = "Select Department";
  final Uuid uuid = const Uuid();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedGender;

  //add patient tofirebase
  Future<void> addPatientToFirestore(PatientModel patient) async {
    try {
      await firestore
          .collection('patients')
          .doc(patient.id)
          .set(patient.toJson());
      print('Patient added to Firestore');
    } catch (e) {
      print('Error adding patient to Firestore: $e');
    }
  }

  Future<void> insertrecord() async {
    if (phoneController.text.isNotEmpty ||
        ageController.text.isNotEmpty ||
        genderController.text.isNotEmpty ||
        phoneController.text.isNotEmpty) {
      try {
        String uri = 'http://localhost/back/insert_record.php';
        var res = await http.post(Uri.parse(uri), body: {
          "name": nameController.text,
          "age": ageController.text,
          "sex": genderController.text,
          "phno": phoneController.text,
        });
        print("http");
        var response = jsonDecode(res.body);
        print("response");
        if (response["success"] == "true") {
          snackbar1(context, "Record Inserted");
        } else {
          snackbar1(context, "Some error occured");
        }
      } catch (e) {
        print(e);
      }
    } else {
      snackbar1(context, "Fill all the Fiels");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: const Text(
              "Add Patients",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: (Colors.blue),
            leading: const BackButton(),
          )),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Patient Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter First Name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Patient Age',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: ageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter First Name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: DropdownButtonFormField<String>(
                          value: selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                          items: ['Male', 'Female', 'Others'].map((option) {
                            return DropdownMenuItem<String>(
                              value: option, // Ensure each value is unique
                              child: Text(option),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Select Gender',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 10),
                  child: SizedBox(
                      width: 250,
                      child: IntlPhoneField(
                        controller: phoneController,
                        showCountryFlag: true,
                        disableLengthCheck: true,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter Phone Number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton.extended(
          onPressed: () {
            log(selectedGender.toString());
            // insertrecord();
            PatientModel newPatient = PatientModel(
              id: uuid.v4(),
              patientName: nameController.text,
              patientAge: ageController.text,
              gender: selectedGender!,
              phNumber: phoneController.text,
            );
            addPatientToFirestore(newPatient);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const MyHomePage()),
                ModalRoute.withName(''));
          },
          label: const Text('SAVE'),
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
