import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project/view/home_screen.dart';

class DoctorEditButton extends StatefulWidget {
  DoctorEditButton({
    super.key,
    required this.doctorData,
  });

  final Map<String, dynamic> doctorData;

  @override
  State<DoctorEditButton> createState() => _DoctorEditButtonState();
}

class _DoctorEditButtonState extends State<DoctorEditButton> {
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController experienceEditingController =
      TextEditingController();

  String? selectedStatus;

  final TextEditingController departmentEditingController =
      TextEditingController();
  final TextEditingController specializationEditingController =
      TextEditingController();

  //update doctor
  Future<void> updateDoctor(
      String doctorId, Map<String, dynamic> updatedData) async {
    try {
      final CollectionReference patientsCollection =
          FirebaseFirestore.instance.collection('doctors');

      await patientsCollection.doc(doctorId).update(updatedData);

      log('Doctor updated successfully');
    } catch (e) {
      log('Error updating Doctor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    nameEditingController.text = widget.doctorData['name'] ?? '';
    experienceEditingController.text = widget.doctorData['experience'] ?? '';
    departmentEditingController.text = widget.doctorData['department'];
    selectedStatus = widget.doctorData['availability'];
    specializationEditingController.text = widget.doctorData['specialization'];

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
                            labelText: 'Experience',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: experienceEditingController,
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
                            labelText: 'department',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: departmentEditingController,
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
                            labelText: 'specialization',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: specializationEditingController,
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
                                value: selectedStatus,
                                onChanged: (newValue) {
                                  selectedStatus = newValue;
                                },
                                items: ['Available', 'Not Available']
                                    .map((option) {
                                  return DropdownMenuItem<String>(
                                    value:
                                        option, // Ensure each value is unique
                                    child: Text(option),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                  hintText: 'Select availability',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        updateDoctor(widget.doctorData['id'], {
                          'name': nameEditingController.text,
                          'experience': experienceEditingController.text,
                          'department': departmentEditingController.text,
                          'specialization':
                              specializationEditingController.text,
                          'availability': selectedStatus
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
