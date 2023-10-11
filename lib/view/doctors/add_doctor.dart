import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/model/doctor.dart';
import 'package:project/view/home_screen.dart';
import 'package:uuid/uuid.dart';

class AddDcotor extends StatefulWidget {
  const AddDcotor({super.key});

  @override
  State<AddDcotor> createState() => _AddDcotorState();
}

class _AddDcotorState extends State<AddDcotor> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController experienceController = TextEditingController();

  final TextEditingController departmentController = TextEditingController();

  final TextEditingController specializatinController = TextEditingController();
  final Uuid uuid = const Uuid();

  String? selectedStateus;

  String departmentValue = "Select Department";

  // File? file;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //add doctor to firesbase firestre
  Future<void> addDoctorToFirestore(DoctorModel doctor) async {
    try {
      await firestore.collection('doctors').doc(doctor.id).set(doctor.toJson());
      print('doctor added to Firestore');
    } catch (e) {
      print('Error adding doctor to Firestore: $e');
    }
  }

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
                      controller: nameController,
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
                      controller: experienceController,
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
                        labelText: 'Department',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: departmentController,
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
                        labelText: 'Specialization',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: specializatinController,
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
                  child: Column(
                    children: [
                      Container(
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
                              value: selectedStateus,
                              onChanged: (newValue) {
                                selectedStateus = newValue;
                              },
                              items:
                                  ['Available', 'Not Available'].map((option) {
                                return DropdownMenuItem<String>(
                                  value: option, // Ensure each value is unique
                                  child: Text(option),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                hintText: 'Select Availabilty',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton.extended(
          onPressed: () {
            DoctorModel newPatient = DoctorModel(
                id: uuid.v4(),
                doctorName: nameController.text,
                experience: experienceController.text,
                department: departmentController.text,
                specialization: specializatinController.text,
                availability: selectedStateus!);
            addDoctorToFirestore(newPatient);
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
