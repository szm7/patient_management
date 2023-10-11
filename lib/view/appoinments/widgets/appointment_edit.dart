import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project/view/home_screen.dart';

class AppointmentEdit extends StatefulWidget {
  AppointmentEdit({
    super.key,
    required this.appointmentData,
  });

  final Map<String, dynamic> appointmentData;

  @override
  State<AppointmentEdit> createState() => _AppointmentEditState();
}

class _AppointmentEditState extends State<AppointmentEdit> {
  final TextEditingController docterNameEditingControllerr =
      TextEditingController();

  final TextEditingController patientNameEditingController =
      TextEditingController();
  final TextEditingController issueEditingController = TextEditingController();
  final TextEditingController dateEditingController = TextEditingController();
  final TextEditingController timeEditingController = TextEditingController();
  final FocusNode timeFocusnode = FocusNode();
  final FocusNode dateFocusnode = FocusNode();

  String? selectedStatus;
  //covert to timeformate
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final formatter = DateFormat.jm(); // Use 'jm' for 12-hour format

    return formatter.format(dateTime);
  }

  //convert tp date formate
  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  //update appointment
  Future<void> updateAppointment(
      String appointmentId, Map<String, dynamic> updatedData) async {
    try {
      final CollectionReference patientsCollection =
          FirebaseFirestore.instance.collection('appointments');

      await patientsCollection.doc(appointmentId).update(updatedData);

      log('appointment updated successfully');
    } catch (e) {
      log('Error updating appointment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    docterNameEditingControllerr.text = widget.appointmentData['doctorName'];
    patientNameEditingController.text = widget.appointmentData['patientName'];
    issueEditingController.text = widget.appointmentData['issue'];
    dateEditingController.text = widget.appointmentData['date'];
    timeEditingController.text = widget.appointmentData['time'];
    selectedStatus = widget.appointmentData['status'];

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                height: 600,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 250,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Doctor Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: docterNameEditingControllerr,
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
                            labelText: 'patient Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: patientNameEditingController,
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
                            labelText: 'Issue',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: issueEditingController,
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
                          onTap: () async {
                            log('message');
                            dateFocusnode.unfocus();
                            DateTime selectedDate = DateTime.now();

                            final schedulDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2100));
                            final String formattedDate =
                                formatDate(schedulDate!);

                            log(formattedDate.toString());
                            dateEditingController.text = formattedDate;
                          },
                          focusNode: dateFocusnode,
                          decoration: const InputDecoration(
                            labelText: 'date',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: dateEditingController,
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
                          onTap: () async {
                            timeFocusnode.unfocus();
                            TimeOfDay selectedTime = TimeOfDay.now(); //
                            final schedulTime = await showTimePicker(
                                context: context, initialTime: selectedTime);
                            String formattedTime =
                                formatTimeOfDay(schedulTime!);

                            log(formattedTime.toString());

                            timeEditingController.text = formattedTime;
                          },
                          focusNode: timeFocusnode,
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: timeEditingController,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                child: DropdownButtonFormField<String>(
                                  value: selectedStatus,
                                  onChanged: (newValue) {
                                    selectedStatus = newValue;
                                  },
                                  items: ['Completed', 'Pending'].map((option) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          option, // Ensure each value is unique
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                    hintText: 'Select status',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ))),
                    InkWell(
                      onTap: () {
                        updateAppointment(widget.appointmentData['id'], {
                          'doctorName': docterNameEditingControllerr.text,
                          'patientName': patientNameEditingController.text,
                          'issue': issueEditingController.text,
                          'date': dateEditingController.text,
                          'time': timeEditingController.text,
                          'status': selectedStatus
                        });
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyHomePage()));
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
