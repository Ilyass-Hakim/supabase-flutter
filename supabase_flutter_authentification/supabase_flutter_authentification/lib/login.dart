
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter_authentification/Home.dart';
import 'package:supabase_flutter_authentification/signup.dart';

import 'main.dart';

/// ****************************************** backend_part***************************************************

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Sign In User
  void signIn() async {
    try {
      await supabase.auth.signInWithPassword(
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
      );
      if (!mounted) return;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Authentication error: ${e.message}",
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "An error occurred: $e",
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 30),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {},
            textColor: Colors.white,
          ),
        ),
      );
    }
  }


  /// ****************************************** Frontend_part***************************************************


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            color: Colors.black,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26)),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blue.shade50),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: 'Enter your email',
                                  prefixIcon: const Icon(Icons.email),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.white70),
                                  ),
                                  hintStyle: const TextStyle(
                                      fontSize: 12.0, color: Colors.white70),
                                      contentPadding: const EdgeInsets.all(12),
                                ),
                                style: const TextStyle(
                                    color: Colors
                                        .white), // This sets the text color to white
                                        
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blue.shade50),
                              ),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  prefixIcon: const Icon(Icons.lock),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.white70),
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.blueGrey.shade300),
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: GestureDetector(
                              onTap: signIn,
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 330,
                                decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Sign In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                              child: RichText(
                                  text: TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: "Already have an account?",
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade300,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: ' ',
                                        style: TextStyle(
                                            color: Colors.indigo.shade300,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const TextSpan(
                                        text: "SignUp",
                                        style: TextStyle(
                                            color: Colors.purpleAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
