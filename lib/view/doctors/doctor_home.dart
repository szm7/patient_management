import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/view/doctors/add_doctor.dart';
import 'package:project/view/doctors/doctor_view.dart';

class HomeDoctors extends StatefulWidget {
  const HomeDoctors({super.key});

  @override
  State<HomeDoctors> createState() => _HomeDoctorsState();
}

class _HomeDoctorsState extends State<HomeDoctors> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddDcotor()));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('doctors').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final doctors = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DocterView(doctorData: data)));
                        },
                        child: Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                                color: const Color(0xffd7e3fc),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        ' Doctor Name : ',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data['name'],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffedf2fb),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        const Text(
                                          ' Id :',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            width: 240,
                                            child: Text(
                                              data['id'],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              FlutterClipboard.copy(data['id']);
                                            },
                                            icon: const Icon(
                                              Icons.copy,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            data['availability'] == 'Available'
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        data['availability'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                    );
                  });
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
