import 'package:flutter/material.dart';
import 'package:project/view/patients/widgets/patient_delete_button.dart';
import 'package:project/view/patients/widgets/patient_edit_button.dart';

class PatientView extends StatefulWidget {
  const PatientView({super.key, required this.patinetData});

  final Map<String, dynamic> patinetData;

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
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
                          text: 'Patient Name : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.patinetData['name'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'Patient Age : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.patinetData['age'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'Patient Gender : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.patinetData['gender'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'Patient Phno : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.patinetData['phNumber'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
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
                PatientEditButton(patientData: widget.patinetData),
                PatientDeleteButton(patientId: widget.patinetData['id'])
              ],
            )
          ],
        ),
      ),
    );
  }
}
