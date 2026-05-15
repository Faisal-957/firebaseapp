import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:widgets_practicing/authscreen/homescreen.dart';
import 'package:widgets_practicing/authscreen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> singup() async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      Get.to(HomeScreen());
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Signup Failed")));
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
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("skip", style: TextStyle(fontSize: 20)),
                ),
              ),
              30.verticalSpace,
              Image.asset("assets/images/Logo.png", scale: 3),
              40.verticalSpace,
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              30.verticalSpace,

              TextFormField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                  label: Text("Full Name"),
                ),
              ),
              20.verticalSpace,
              TextFormField(
                controller: emailcontroller,

                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  label: Text("Email"),
                ),
              ),
              20.verticalSpace,
              TextFormField(
                controller: passwordcontroller,

                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  label: Text("Password"),
                ),
              ),
              20.verticalSpace,
              Button(title: "Create Account", onpressed: singup),
              20.verticalSpace,
              Text('Connect With', style: TextStyle(fontSize: 20)),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},

                    child: Image.asset("assets/images/image.png", scale: 3),
                  ),
                  20.horizontalSpace,
                  Image.asset("assets/images/image6.png", scale: 3),
                ],
              ),
              20.verticalSpace,
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  "Already Have an Account",
                  style: TextStyle(color: Colors.green.shade700, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
