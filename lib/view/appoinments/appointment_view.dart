import 'package:flutter/material.dart';
import 'package:project/view/appoinments/widgets/appoinment_delete.dart';
import 'package:project/view/appoinments/widgets/appointment_edit.dart';
import 'package:project/view/doctors/widgets/doctor_delete_button.dart';
import 'package:project/view/doctors/widgets/doctor_edit_button.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key, required this.appointmentData});

  final Map<String, dynamic> appointmentData;

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
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
                          text: widget.appointmentData['doctorName'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: ' patient Name:',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.appointmentData['patientName'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'issue : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.appointmentData['issue'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: ' date : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.appointmentData['date'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: ' time : ',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      TextSpan(
                          text: widget.appointmentData['time'],
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
                              widget.appointmentData['status'] == 'Completed'
                                  ? Colors.green
                                  : Colors.red,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.appointmentData['status'],
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
                AppointmentEdit(appointmentData: widget.appointmentData),
                AppointmentDeleteButton(
                    appointmetnId: widget.appointmentData['id'])
              ],
            )
          ],
        ),
      ),
    );
  }
}
