import 'package:flutter/material.dart';
import 'package:login/Widgets/round_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login/pages/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/utils.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _fromKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 var obsecureText =true;
 bool loading =false;
  FirebaseAuth _auth =FirebaseAuth.instance;
  //checking email is vailid or not

  void VailidEmail(){
    final bool isEmail= EmailValidator.validate(emailController.text.trim());
    if (isEmail){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vailid email")));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("invailid email")));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
void SignUp(){
  setState(() {
    loading = loading;
  });
  _auth.createUserWithEmailAndPassword(email:  emailController.text.toString(),
      password: passwordController.text.toString()).then((value) {

  }).onError((error, stackTrace) {
    utils().ToastMessage(error.toString());
    setState(() {
      loading = loading;
    });
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(key: _fromKey,
              child: Column(
                children: [
                  TextFormField(
                    controller:emailController ,

                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_rounded),

                      enabledBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.blueGrey,width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.green,width: 1),
                          borderRadius: BorderRadius.circular(15)),
                    ),

                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Email";
                      }else{
                        return null;
                      }
                    },
                  ),


                  SizedBox(height: 20,),
                  TextFormField(
                    controller:passwordController ,
                    obscureText: obsecureText,
                    decoration: InputDecoration(
                      hintText: "password",
                      prefixIcon: Icon(Icons.key_outlined),
                      suffixIcon:  GestureDetector(
                        onTap:(){
                          setState(() {
                            obsecureText =! obsecureText;
                          });
                        } ,child: obsecureText ? const Icon(Icons.visibility_off) :
                      Icon(Icons.visibility),

                      ),
                      enabledBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.blueGrey,width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.green,width: 1),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Email";
                      }else{
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
              title:"Sign Up",
              loading:loading,
              ontap: () {
                if (_fromKey.currentState!.validate()) {
                             SignUp();
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text  ("Already have an account ?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                }, child: Text("login"))],

            ),
          ],
        ),
      ),
    );
  }
}
