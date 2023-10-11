import 'package:flutter/material.dart';
import 'package:project/view/doctors/widgets/doctor_delete_button.dart';
import 'package:project/view/doctors/widgets/doctor_edit_button.dart';
import 'package:project/view/patients/widgets/patient_delete_button.dart';
import 'package:project/view/patients/widgets/patient_edit_button.dart';

class DocterView extends StatefulWidget {
  const DocterView({super.key, required this.doctorData});

  final Map<String, dynamic> doctorData;

  @override
  State<DocterView> createState() => _DocterViewState();
}

class _DocterViewState extends State<DocterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('doctor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'doctor Name : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.doctorData['name'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: ' Experience : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.doctorData['experience'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'Department : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.doctorData['department'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: ' Specialization : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.doctorData['specialization'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              widget.doctorData['availability'] == 'Available'
                                  ? Colors.green
                                  : Colors.red,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.doctorData['availability'],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DoctorEditButton(doctorData: widget.doctorData),
                DoctorDeleteButton(doctorid: widget.doctorData['id'])
              ],
            )
          ],
        ),
      ),
    );
  }
}
