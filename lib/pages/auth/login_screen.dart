import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/Widgets/round_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login/pages/auth/forgotpassword.dart';
import 'package:login/pages/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/pages/screen/profilePage.dart';
import 'package:login/utils/utils.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  bool isEmail = false;
  var obsecureText = true;
  final _auth = FirebaseAuth.instance;

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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 3, 0, 28),
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Text("login"),
        //   centerTitle: true,
        // ),
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
                      const SizedBox(
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
                        children: const[
                          SizedBox(width: 10,),
                           Text(
                            "Sign In",
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
                        // onChanged: (value){
                        //   setState(() {
                        //     // isEmailCorrect = isEmail(value);
                        //   });
                        // },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
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

                        onChanged: (value) {
                          numLook?.change(value.length.toDouble());
                        },
                        maxLength: 30,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter roll no";
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
                        style: TextStyle(color: Colors.white),
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
                            return "Enter Password";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPassword()));
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                const SizedBox(height: 65),
                //button
                RoundButton(
                  title: "Sign In",
                  ontap: () {
                    passwordFocusNode.unfocus();
                    emailFocusNode.unfocus();
                    if (_fromKey.currentState!.validate()) {
                      trigSuccess?.change(true);
                      login();
                    } else {
                      trigFail?.change(true);
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => const profile())));
    } on FirebaseAuthException catch (e) {
      print(e);

      // Utils.showSnackBar(e.message);
    }
  }
}
