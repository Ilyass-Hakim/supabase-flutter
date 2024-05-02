

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter_authentification/UpdatePage.dart';
import 'package:supabase_flutter_authentification/login.dart';
import 'package:supabase_flutter_authentification/signup.dart';




/// ****************************************** backend_part***************************************************
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://azvjpogzwqfeumfwztek.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF6dmpwb2d6d3FmZXVtZnd6dGVrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQzMTg3OTIsImV4cCI6MjAyOTg5NDc5Mn0.E4KIAq_rAGrefOt42WuK2TLEj45iCtHj7_Du--cwXmw',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Sign Out User
  Future<void> signOut() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const UpdatePage()));
  }




/// ****************************************** Frontend_part***************************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 250,
                height: 250,
                child: Image.asset(
                  'assets/images/personal_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding:
                    const EdgeInsets.symmetric(horizontal: 115, vertical: 7),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Log in',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding:
                    const EdgeInsets.symmetric(horizontal: 110, vertical: 7),
                foregroundColor: Colors.white,
              ),
              child: const Text('Sign up',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ),
          ],
        ),
      ),
    );
  }
}
