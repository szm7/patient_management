import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/model/appointment.dart';
import 'package:project/view/appoinments/widgets/doctor_dropdown.dart';
import 'package:project/view/appoinments/widgets/patient_dropdown.dart';
import 'package:project/view/home_screen.dart';
import 'package:uuid/uuid.dart';

String? selectePatient;
String? selectedDoctor;

class AddAppoi extends StatefulWidget {
  const AddAppoi({super.key});

  @override
  State<AddAppoi> createState() => _AddAppoiState();
}

class _AddAppoiState extends State<AddAppoi> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode timeFocusnode = FocusNode();
  final FocusNode dateFocusnode = FocusNode();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedStatus;

  String departmentValue = "Select Department";

  final Uuid uuid = const Uuid();
  final TextEditingController patientNameController = TextEditingController();

  final TextEditingController doctorNameController = TextEditingController();

  final TextEditingController issueController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

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

  //add appintment to firestore
  Future<void> addAppointmentToFirestore(AppointmentModel appointment) async {
    try {
      await firestore
          .collection('appointments')
          .doc(appointment.id)
          .set(appointment.toJson());
      print('appointment added to Firestore');
    } catch (e) {
      print('Error adding appoinmetnst to Firestore: $e');
    }
  }

  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: const Text(
              "Add Doctor",
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
                PatientDropdown(
                  patientNameController: patientNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                DoctorDropdown(
                  doctorNameController: doctorNameController,
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
                      controller: issueController,
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
                        final String formattedDate = formatDate(schedulDate!);

                        log(formattedDate.toString());
                        dateController.text = formattedDate;
                      },
                      focusNode: dateFocusnode,
                      decoration: const InputDecoration(
                        labelText: 'date',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: dateController,
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
                        String formattedTime = formatTimeOfDay(schedulTime!);

                        log(formattedTime.toString());

                        timeController.text = formattedTime;
                      },
                      focusNode: timeFocusnode,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: timeController,
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
                              items: ['Completed', 'Pending'].map((option) {
                                return DropdownMenuItem<String>(
                                  value: option, // Ensure each value is unique
                                  child: Text(option),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                hintText: 'Select status',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )))
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton.extended(
          onPressed: () {
            log(selectedDoctor.toString());
            final appointment = AppointmentModel(
                id: uuid.v4(),
                patientName: selectePatient!,
                doctorName: selectedDoctor!,
                issue: issueController.text,
                date: dateController.text,
                time: timeController.text,
                status: selectedStatus!);
            log('before adding app');
            addAppointmentToFirestore(appointment);
            log('After adding app');
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyHomePage()));
          },
          label: const Text('SAVE'),
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }

  insertrecord() {}
}
