import 'package:flutter/material.dart';
import 'package:fps_ignite_mobile_app_2/db_operations/authentication.dart';
import 'package:fps_ignite_mobile_app_2/pages/owned_time_slots.dart';
import 'package:fps_ignite_mobile_app_2/pages/time_slots.dart';
import 'package:fps_ignite_mobile_app_2/pages/tvc_sets.dart';
import 'package:fps_ignite_mobile_app_2/pages/ic_balance.dart';
import 'package:fps_ignite_mobile_app_2/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('IGNITE_APP_DATABASE');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    String initialPageRoute = '/login';
    if (getDelID() != null) {
      initialPageRoute = '/ics_tracker';
    } else {
      initialPageRoute = '/login';
    }

    return MaterialApp(
      title: 'Ignite App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.grey[900]
      ),


      initialRoute: initialPageRoute,
      routes: <String, WidgetBuilder> {
        '/ics_tracker':(context) => ICs_Tracker(),
        '/login':(context) => DelegationLoginPage(),
        '/tvc_sets':(context) => TVCSets(),
        '/buy_slots':(context) => TimeSlots(tvc_set_name: '', del_group: '',),
        '/owned_slots':(context) => OwnedTimeSlots(tvc_set_name: '', del_group: '',),
      },
    );
  }
}

