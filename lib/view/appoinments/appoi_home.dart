import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/view/appoinments/add_appoi.dart';
import 'package:project/view/appoinments/appointment_view.dart';

class HomeAppontments extends StatefulWidget {
  const HomeAppontments({super.key});

  @override
  State<HomeAppontments> createState() => _HomeAppontmentsState();
}

class _HomeAppontmentsState extends State<HomeAppontments> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //doctore name get
  Future<DocumentSnapshot> fetchDoctor(String doctorId) async {
    final doctorDocument =
        await firestore.collection('doctors').doc(doctorId).get();
    return doctorDocument;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: firestore.collection('appointments').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var appointments = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data();

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AppointmentView(appointmentData: data)));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xffd7e3fc),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    ' Doctor id : ',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['doctorName'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    ' patient id : ',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['patientName'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    ' Status : ',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['status'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: data['status'] == 'Completed'
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddAppoi()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
