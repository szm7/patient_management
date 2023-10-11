import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/view/home_screen.dart';

class AppointmentDeleteButton extends StatelessWidget {
  const AppointmentDeleteButton({super.key, required this.appointmetnId});

  final String appointmetnId;

  //Appointment delete function
  Future<void> deleteAppointment(String appointmentId) async {
    try {
      final CollectionReference patientsCollection =
          FirebaseFirestore.instance.collection('appointments');

      await patientsCollection.doc(appointmentId).delete();

      log('appoinment deleted successfully');
    } catch (e) {
      log('Error deleting appointment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Confirm Delete'),
                content: const Text('Do you want to delete this appointment?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        deleteAppointment(appointmetnId);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              );
            });
      },
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: const Center(child: Text('Delete')),
      ),
    );
  }
}
