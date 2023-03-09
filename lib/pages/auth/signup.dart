import 'package:flutter/material.dart';
import 'package:login/Widgets/round_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login/pages/auth/emailverification.dart';
import 'package:login/pages/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rive/rive.dart';

import '../../utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  final _fromKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var obsecureText = true;
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  //checking email is vailid or not
  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    confirmPasswordFocusNode.addListener(confirmpasswordFocus);
  }

  void VailidEmail() {
    final bool isEmail = EmailValidator.validate(emailController.text.trim());
    if (isEmail) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Vailid email")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("invailid email")));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    confirmPasswordFocusNode.removeListener(confirmpasswordFocus);
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  void confirmpasswordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 0, 28),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: RiveAnimation.asset(
                        "assets/animated_login_character.riv",
                        fit: BoxFit.fitHeight,
                        stateMachines: const ["Login Machine"],
                        onInit: (artboard) {
                          controller = StateMachineController.fromArtboard(
                              artboard, "Login Machine");
                          if (controller == null) {
                            return;
                          }
                          artboard.addController(controller!);
                          isChecking = controller?.findInput("isChecking");
                          numLook = controller?.findInput("numLook");
                          isHandsUp = controller?.findInput("isHandsUp");
                          trigSuccess = controller?.findInput("trigSuccess");
                          trigFail = controller?.findInput("trigSuccess");
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 214, 252),
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter roll no",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0),
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Color.fromARGB(77, 217, 217, 217),
                        counterText: '',
                      ),
                      maxLength: 30,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: obsecureText,
                      decoration: InputDecoration(
                        hintText: "Enter password",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.key_outlined,
                          color: Colors.white,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obsecureText = !obsecureText;
                            });
                          },
                          child: obsecureText
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0),
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Color.fromARGB(77, 217, 217, 217),
                        counterText: '',
                      ),
                      maxLength: 8,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocusNode,
                      obscureText: obsecureText,
                      decoration: InputDecoration(
                        hintText: "Re-enter password",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon:
                            Icon(Icons.key_outlined, color: Colors.white),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obsecureText = !obsecureText;
                            });
                          },
                          child: obsecureText
                              ? const Icon(Icons.visibility_off,
                                  color: Colors.white)
                              : Icon(Icons.visibility, color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0),
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Color.fromARGB(77, 217, 217, 217),
                        counterText: '',
                      ),
                      maxLength: 8,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm password";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),
              //button
              RoundButton(
                title: "Sign Up",
                loading: loading,
                ontap: () {
                  emailFocusNode.unfocus();
                  passwordFocusNode.unfocus();
                  if (_fromKey.currentState!.validate()) {
                    trigSuccess?.change(true);
                    SignUp();
                  } else {
                    trigFail?.change(true);
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 214, 252),
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future SignUp() async {
    // setState(() {
    //   loading = loading;
    // });
    // _auth.createUserWithEmailAndPassword(email:  emailController.text.toString(),
    //     password: passwordController.text.toString()).then((value) {

    // }).onError((error, stackTrace) {
    //   utils().ToastMessage(error.toString());
    //   setState(() {
    //     loading = loading;
    //   });
    // });
    final isValid = _fromKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      String _email = emailController.text;
      String _password = passwordController.text;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerifyEmailPage(email: _email, password: _password)));
    } on FirebaseAuthException catch (e) {
      print(e);

      // Utils.showSnackBar(e.message);
    }
  }
}
