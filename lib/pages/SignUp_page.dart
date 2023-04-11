import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback SignInScreen;
  const SignUpPage({super.key, required this.SignInScreen});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obsecureText = true;
  bool checkpoint = true;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var ageController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  void ShowPasswordText() {
    setState(() {
      if (checkpoint) {
        _obsecureText = false;
        checkpoint = false;
      } else {
        _obsecureText = true;
        checkpoint = true;
      }
    });
  }

  Future _singUp() async {
    if (passwordConfirm()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      getUserData(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        emailController.text.trim(),
        int.parse(ageController.text.trim()),
      );
    }
  }

  bool passwordConfirm() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future getUserData(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'firstName': firstNameController,
      'lastName': lastNameController,
      'email': emailController,
      'age': ageController,
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Here!",
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              // Description Text...
              Text("If You're New, Your're At Right Place",
                  style: TextStyle(fontSize: 21, color: Colors.white)),
              SizedBox(height: 50),

              // First Name TextField For Login...
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  controller: firstNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "First Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Last Name TextField For Login...
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  controller: lastNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Age TextField For Login...
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  controller: ageController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Age",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Email TextField For Login...
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Password TextField for Login...
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  obscureText: _obsecureText,
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: ShowPasswordText,
                        child: Icon(Icons.remove_red_eye),
                      ),
                    ),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Confirm Password Textfield
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  obscureText: _obsecureText,
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: ShowPasswordText,
                        child: Icon(Icons.remove_red_eye),
                      ),
                    ),
                    hintText: "Confirm Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Container to make a Customized sign in Button...
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: GestureDetector(
                  onTap: _singUp,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Row for Sign Button and a Message of "Not a Member"...
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text for Not a Member...
                  Text(
                    'Already a User? ',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  // Container to make a Customized sign Up Button...
                  GestureDetector(
                    onTap: widget.SignInScreen,
                    child: Container(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
