import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/pages/auth/login_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final snackBar = const SnackBar(
    content: Text('Password Reset Email Sent'),
  );
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(254, 3, 0, 28),
      body: Center(
          child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 262,
            ),
            const SizedBox(
              width: 173,
              height: 25,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Enter your email id',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 260,
              height: 37,
              child: TextFormField(
                controller: emailController,
                cursorColor: const Color.fromARGB(255, 255, 255, 255),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  // hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    
                      borderSide:
                          const BorderSide(width: 0, color: Color.fromARGB(254, 42, 69, 73),),
                          borderRadius: BorderRadius.circular(5)),
                  filled: true,
                  fillColor: Color.fromARGB(254, 42, 69, 73),
                ),
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 35,
              width: 119,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(254, 28, 111, 125),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: resetPassword,
                  child: const Center(
                    child: SizedBox(
                      width: 43,
                      height: 19,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      )),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      // Utils.showSnackBar('Password Reset Email Sent');

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MessagePage()));
    } on FirebaseAuthException catch (e) {
      print(e);

      // Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(254, 3, 0, 28),
      body: Center(
          child: Column(
        children: [
          const Spacer(),
          Container(
              width: 291,
              height: 172,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(254, 30, 50, 53),
                border: Border.all( color: Color.fromARGB(254, 0, 214, 252),width: 0)
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 56,
                    width: 272,
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                            'An email to reset your password\n     has been sent to the entered\n                   email address.',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                    
                  ),
                  const Divider(
                    color: Color.fromARGB(254, 0, 214, 252),
                  ),
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
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          const Spacer(
            flex: 2,
          ),
        ],
      )),
    );
  }
}
