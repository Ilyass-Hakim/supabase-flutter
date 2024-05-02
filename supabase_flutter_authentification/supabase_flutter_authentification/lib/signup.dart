
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter_authentification/Home.dart';
import 'package:supabase_flutter_authentification/login.dart';
import 'package:supabase_flutter_authentification/main.dart';


/// ****************************************** backend_part***************************************************
//Sign Up User

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  bool passwordsMatch = false;

  void signUp() async {
    try {
      // Sign up the user
      await supabase.auth.signUp(
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
        data: {
          'username': usernameController.text.trim(),
        },
      );
      // Extract user ID
      final user = supabase.auth.currentUser!.id;

      // Insert user data into the 'clients' table
      await supabase.from('clients').insert([
        {
          'clientId': user,
          'fullName': fullNameController.text.trim(),
        },
      ]);

      if (!mounted) return;

      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
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

  @override
  void initState() {
    super.initState();
    _checkPasswordsMatch();
  }

  void _checkPasswordsMatch() {
    setState(() {
      passwordsMatch =
          passwordController.text == confirmPasswordController.text;
    });
  }

  String? passwordErrorText(bool passwordsMatch) {
    return passwordsMatch ? null : 'Passwords don\'t match';
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
                          const Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blue.shade50),
                              ),
                              child: TextFormField(
                                controller: emailController,
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
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.blue.shade50,
                                  width: 1,
                                ),
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
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.blue.shade50,
                                  width: 1,
                                ),
                              ),
                              child: TextFormField(
                                controller: confirmPasswordController,
                                onChanged: (_) => _checkPasswordsMatch(),
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  prefixIcon: const Icon(Icons.done),
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
                                  errorText: passwordsMatch
                                      ? null
                                      : 'Passwords do not match',
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.blue.shade50,
                                ),
                              ),
                              child: TextFormField(
                                controller: usernameController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: 'Enter your username',
                                  prefixIcon: const Icon(Icons.person),
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
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.blue.shade50,
                                ),
                              ),
                              child: TextFormField(
                                controller: fullNameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your fullName',
                                  prefixIcon: const Icon(Icons.person),
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
                              onTap: signUp,
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 330,
                                decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Sign Up",
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
                                            const LoginPage()));
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Already have an account?",
                                      style: TextStyle(
                                        color: Colors.blueGrey.shade300,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ',
                                      style: TextStyle(
                                          color: Colors.indigo.shade300,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const TextSpan(
                                      text: "SignIn",
                                      style: TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
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
