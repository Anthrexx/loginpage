import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage(
      {super.key, required this.email,required this.password});
  final String email;
  final String password;
  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  // String? userId;

  getData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // email = prefs.getString('email');
    // password = prefs.getString('password');
    // print(email);
    // print(password);
  }

  @override
  initState() {
    super.initState();
    getData();
    var user = FirebaseAuth.instance.currentUser!;
    isEmailVerified = user.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
    }
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      // Utils.showSnackBar(e.toString());
      // print(e);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    if (!mounted) return;
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: ((context) => BottomNav())),
      //     (route) => false);
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
        color: const Color.fromARGB(255, 3, 0, 28),
        
        child: Scaffold(
         
          backgroundColor: Colors.transparent,
          body: 
             Center(
              child: Container(
                height: 340,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 30, 50, 53)
                ),
                child: Column(
                  
                  children:  [
                 const   Icon(Icons.check_circle,size: 180,color: Color.fromARGB(255, 90, 209, 34),),
                    const Text(
                      "A verify link has been successfully send to your registered email address.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  const  SizedBox(height: 19,),
                   const Divider(
                      color: Color.fromARGB(255, 0, 214, 252),
                    ),
                   const SizedBox(height: 10,),
                    SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const LoginScreen())),
                            (route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            size: 22,
                            color:  Color.fromARGB(254, 121, 255, 249),
                          ),
                          Text(
                            'Back to sign in',
                            style: TextStyle(
                                color: Color.fromARGB(254, 121, 255, 249),
                                fontSize: 22,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                    
                  ],
                ),
              ),
            ),
          
        ));
  }
}
