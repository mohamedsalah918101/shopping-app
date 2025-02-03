import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/shopping_page.dart';
import 'package:page_transition/page_transition.dart';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool hiddenPassword = true;
  bool hiddenPassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        title: Text(
          "SignUp Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              TextFormField(
                controller: nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (value[0] != value[0].toUpperCase()) {
                    return 'First letter must be capitalized';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Email must contain @';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                obscureText: hiddenPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      togglePassword();
                    },
                    icon: Icon(
                      hiddenPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: confirmPasswordController,
                style: TextStyle(color: Colors.white),
                obscureText: hiddenPassword2,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      togglePassword2();
                    },
                    icon: Icon(
                      hiddenPassword2 ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Password do not match';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.green,
                            title: Text(
                              "Success",
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Text("Account created successfully!",
                                style: TextStyle(color: Colors.white)),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog

                                  // Fade animation using PageTransition Package
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      alignment: Alignment.topCenter,
                                      duration: Duration(seconds: 2),
                                      child: ShoppingPage(),
                                    ),
                                  );
                                },
                                child: Text("Close",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          );
                        },
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showErrorSnackBar('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        showErrorSnackBar(
                            'The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    if (nameController.text.isEmpty ||
                        nameController.text[0] !=
                            nameController.text[0].toUpperCase()) {
                      showErrorSnackBar(
                          "Full name must start with a capital letter");
                    } else if (!emailController.text.contains('@')) {
                      showErrorSnackBar("Email must contain @");
                    } else if (passwordController.text.length < 6) {
                      showErrorSnackBar(
                          "Password must be at least 6 characters");
                    } else if (confirmPasswordController.text !=
                        passwordController.text) {
                      showErrorSnackBar("Passwords do not match");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      // Right to Left animation using PageTransition Package
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          alignment: Alignment.topCenter,
                          duration: Duration(seconds: 1),
                          child: LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  togglePassword() {
    hiddenPassword = !hiddenPassword;
    setState(() {});
  }

  togglePassword2() {
    hiddenPassword2 = !hiddenPassword2;
    setState(() {});
  }

  showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
