import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  final TextEditingController forgotcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isloading = false;
  void forgotpass() async {
    try {
      setState(() {
        isloading = true;
      });
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgotcontroller.text.trim(),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password reset email sent")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/lock.png", scale: 3),
              20.verticalSpace,
              Text(
                textAlign: TextAlign.center,
                "Forgot Password",
                maxLines: 2,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              20.verticalSpace,
              Text(
                textAlign: TextAlign.center,
                "Please enter your registered email, We will send you OTP",
                maxLines: 2,
                style: TextStyle(fontSize: 20),
              ),
              40.verticalSpace,
              TextFormField(
                controller: forgotcontroller,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  label: Text("Email"),
                ),
              ),
              30.verticalSpace,

              SizedBox(
                height: 50.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff02C778),
                  ),

                  onPressed: isloading ? null : forgotpass,
                  child: isloading
                      ? CircularProgressIndicator()
                      : Text(
                          "Reset Passsword",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
