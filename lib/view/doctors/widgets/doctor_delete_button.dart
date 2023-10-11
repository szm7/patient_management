import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/view/home_screen.dart';

class DoctorDeleteButton extends StatelessWidget {
  const DoctorDeleteButton({super.key, required this.doctorid});

  final String doctorid;

  //Doctor delete function
  Future<void> deleteDoctor(String patientId) async {
    try {
      final CollectionReference patientsCollection =
          FirebaseFirestore.instance.collection('doctors');

      await patientsCollection.doc(patientId).delete();

      log('docter deleted successfully');
    } catch (e) {
      log('Error deleting doctor: $e');
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
                content: const Text('Do you want to delete this doctor?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        deleteDoctor(doctorid);
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
