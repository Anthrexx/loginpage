import 'package:flutter/material.dart';
import 'package:login/Widgets/round_button.dart';
import 'package:email_validator/email_validator.dart';
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

  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  final _fromKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var obsecureText = true;
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  //checking email is vailid or not
  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
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
    emailController.dispose();
    passwordController.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign Up"),
        centerTitle: true,
      ),
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
                        "assets/2244-4437-animated-login-screen.riv",
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
                          trigFail = controller?.findInput("trigFail");
                        },
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_rounded),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: obsecureText,
                      decoration: InputDecoration(
                        hintText: "password",
                        prefixIcon: Icon(Icons.key_outlined),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obsecureText = !obsecureText;
                            });
                          },
                          child: obsecureText
                              ? const Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
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
              const SizedBox(height: 30),
              Row(
                children: [
                  Text("Already have an account ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text("login"))
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
    } on FirebaseAuthException catch (e) {
      print(e);

      // Utils.showSnackBar(e.message);
    }
  }
}
