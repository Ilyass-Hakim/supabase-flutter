
import 'package:flutter/material.dart';
import 'package:supabase_flutter_authentification/UpdatePage.dart';
import 'package:supabase_flutter_authentification/main.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



/// ****************************************** Frontend_part***************************************************

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              icon: const Icon(
                Icons.logout_sharp,
                color: Color.fromARGB(255, 160, 87, 183),
                size: 30,
              )),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/personal_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Here you can update you profil',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdatePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding:
                    const EdgeInsets.symmetric(horizontal: 115, vertical: 7),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Update',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
