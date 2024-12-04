import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'admin_login.dart';
import 'admin_dashboard.dart';
import 'voting_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCv_S8rN2ZK83o-EC560NkAQu-5qoDN-gg",
          appId: "1:263949668533:web:80faf8586dbf99bcbdeefc",
          messagingSenderId: "263949668533",
          projectId: "votingsystem-105d7"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voting System',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/adminLogin': (context) => AdminLoginPage(),
        '/adminDashboard': (context) => AdminDashboard(),
        '/votingForm': (context) => VotingForm(),
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Voting System')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose Your Role',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/adminLogin');
              },
              child: Text('Admin'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/votingForm');
              },
              child: Text('User'),
            ),
          ],
        ),
      ),
    );
  }
}
