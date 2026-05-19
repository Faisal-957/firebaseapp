// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:widgets_practicing/authscreen/forgotpassword.dart';
import 'package:widgets_practicing/authscreen/homescreen.dart';
import 'package:widgets_practicing/authscreen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController logincontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isvisible = false;

  ////////////////////////////logggin function////////////////////////////////////////////
  void login() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: logincontroller.text.trim(),
        password: passcontroller.text.trim(),
      );
      Get.to(HomeScreen());

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successful")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /////////////google signin funtion//////////////////////////////////////////////
  void signinwithgoogel() async {
    String clintid =
        "473791988007-kplhm1sqve3923qgeeik30v59m75kb1r.apps.googleusercontent.com";
    try {
      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(serverClientId: clintid);
      GoogleSignInAccount account = await signIn.authenticate();
      GoogleSignInAuthentication googleAuth = account.authentication;

      final creadential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(creadential);
      Get.to(HomeScreen());
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text("skip", style: TextStyle(fontSize: 20)),
                ),
              ),
              30.verticalSpace,
              Image.asset("assets/images/Logo.png", scale: 3),
              40.verticalSpace,
              Text(
                "Create Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              30.verticalSpace,
              ///////////for email////////////////
              TextFormField(
                controller: logincontroller,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  label: Text("Email"),
                ),
              ),
              20.verticalSpace,
              ///////////for password////////////////
              TextFormField(
                obscureText: isvisible,
                controller: passcontroller,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                    icon: Icon(Icons.remove_red_eye),
                  ),

                  prefixIcon: Icon(Icons.lock),
                  label: Text("Password"),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.centerEnd,
                child: TextButton(
                  onPressed: () {
                    Get.to(Forgotpass());
                  },
                  child: Text("Forgot Password"),
                ),
              ),
              20.verticalSpace,
              Button(title: "Log In", onpressed: login),
              10.verticalSpace,
              Button(
                title: " Create an Account",
                onpressed: () {
                  Get.to(SignupScreen());
                },
              ),
              20.verticalSpace,
              Text('Connect With', style: TextStyle(fontSize: 20)),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      signinwithgoogel();
                    },

                    child: Image.asset("assets/images/image.png", scale: 3),
                  ),
                  20.horizontalSpace,
                  Image.asset("assets/images/image6.png", scale: 3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onpressed;

  const Button({super.key, required this.title, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,

      child: Container(
        height: 50.h,
        width: 250.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: AlignmentGeometry.centerLeft,
            end: AlignmentGeometry.centerRight,
            colors: [Color(0xff28AB86), Color(0xff02C778)],
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
