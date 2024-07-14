import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/rocket_league.dart';
import 'package:vlr/app/rocket_league/services/api_service.dart' as rocketLeague;
import 'package:vlr/firebase_options.dart';


void main() async {
  rocketLeague.fetchEvents();
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
    return MaterialApp(
      home: const RocketLeague(),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}