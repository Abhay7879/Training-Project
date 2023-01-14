// ignore_for_file: avoid_print, dead_code
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training_project/sign_up.dart';
import 'package:training_project/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formkey = GlobalKey<FormState>();

  late String _password;
  late String _email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.orange,
                      Colors.green,
                    ],
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    title: const Text("Login Page"),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 120,
                        ),
                        const Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.brown,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (!(RegExp(
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(value!))) {
                                      return "Invalid email id";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _email = value!,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    prefixIcon: Icon(Icons.password),
                                  ),
                                  validator: (value) {
                                    if (!value!.contains(RegExp(r'[A-Z]')) ||
                                        !value.contains(RegExp(r'[a-z]')) ||
                                        !value.contains(RegExp(r'[0-9]')) ||
                                        !value.contains(RegExp(
                                            r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]'))) {
                                      return "invalid";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _password = value!,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(left: 90)),
                                    TextButton(
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          _formkey.currentState!.save();

                                          print(_password);
                                          print(_email);

                                          FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: _email,
                                                  password: _password)
                                              .then((value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(),
                                                ));
                                          }).catchError((e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'invalid user id and password'),
                                            ));
                                            print(e);
                                          });
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.blue),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 25)),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    signup()));
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.blue),
                                      child: Text(
                                        "SignUp",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
