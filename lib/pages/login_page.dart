import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/pages/ForgottonPassword_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback signUpScreen;
  const LoginPage({super.key, required this.signUpScreen});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obsecureText = true;
  bool checkpoint = true;

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

  Future _signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Login Page Image

              // Image.asset('assets/images/Login12.png', scale: 2),
              Image.asset(
                "assets/images/giphy.gif",
                scale: 1,
              ),
              // Heading Text...

              SizedBox(height: 30),
              Text(
                "Hello There!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold),
              ),
              // Description Text...
              Text("Login Here to Get Your First Order!",
                  style: TextStyle(fontSize: 21, color: Colors.white)),
              SizedBox(height: 50),

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
              // SizedBox(height: 10),

              //Forgot Password Button
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ForgotPassword();
                          },
                        ));
                      },
                      child: Text(
                        "forgot password?",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              // Container to make a Customized sign in Button...
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: GestureDetector(
                  onTap: _signIn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Text(
                          "Sign in",
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
                    'Not a Member? ',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  // Container to make a Customized sign Up Button...
                  GestureDetector(
                    onTap: widget.signUpScreen,
                    child: Container(
                      child: Text(
                        "Sign up",
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
