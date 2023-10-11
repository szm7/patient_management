import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:project/view/appoinments/appoi_home.dart';
import 'package:project/view/doctors/doctor_home.dart';
import 'package:project/view/patients/patients_home.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  int _homeSelectedIndex = 0;
  final _homePages = const [HomePatients(), HomeAppontments(), HomeDoctors()];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          'Health Care System',
        ),
      ),
      body: _homePages[_homeSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        //selectedIconTheme: IconThemeData(color: primary, size: 30),
        //unselectedIconTheme: IconThemeData(color: secondary, size: 15),
        selectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

        currentIndex: _homeSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _homeSelectedIndex = newIndex;
          });
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.local_hospital_sharp,
              ),
              label: "Patients"),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.add_chart_sharp,
              ),
              label: "Appointment"),
          const BottomNavigationBarItem(
              icon: Icon(BootstrapIcons.hospital), label: "Doctors"),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
