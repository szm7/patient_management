import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project/view/home_screen.dart';

class PatientEditButton extends StatefulWidget {
  PatientEditButton({
    super.key,
    required this.patientData,
  });

  final Map<String, dynamic> patientData;

  @override
  State<PatientEditButton> createState() => _PatientEditButtonState();
}

class _PatientEditButtonState extends State<PatientEditButton> {
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController ageEditingController = TextEditingController();

  String? selectedGender;

  final TextEditingController phoneEditingController = TextEditingController();

  //update patient
  Future<void> updatePatient(
      String patientId, Map<String, dynamic> updatedData) async {
    try {
      final CollectionReference patientsCollection =
          FirebaseFirestore.instance.collection('patients');

      await patientsCollection.doc(patientId).update(updatedData);

      log('Patient updated successfully');
    } catch (e) {
      log('Error updating patient: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    nameEditingController.text = widget.patientData['name'] ?? '';
    ageEditingController.text = widget.patientData['age'] ?? '';
    phoneEditingController.text = widget.patientData['phNumber'];
    selectedGender = widget.patientData['gender'];

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 250,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: nameEditingController,
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
                            labelText: 'Age',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: ageEditingController,
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
                                  selectedGender = newValue;
                                },
                                items:
                                    ['Male', 'Female', 'Others'].map((option) {
                                  return DropdownMenuItem<String>(
                                    value:
                                        option, // Ensure each value is unique
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
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 10),
                      child: SizedBox(
                          width: 250,
                          child: IntlPhoneField(
                            controller: phoneEditingController,
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
                    InkWell(
                      onTap: () {
                        updatePatient(widget.patientData['id'], {
                          'name': nameEditingController.text,
                          'age': ageEditingController.text,
                          'phNumber': phoneEditingController.text,
                          'gender': selectedGender
                        });

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text('Update'),
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      },
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        child: const Center(child: Text('Update')),
      ),
    );
  }
}
