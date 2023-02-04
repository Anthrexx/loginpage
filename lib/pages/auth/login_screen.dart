import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/Widgets/round_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login/pages/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/utils/utils.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _fromKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isEmail =false;
  var obsecureText =true;
  final _auth =FirebaseAuth.instance;

  //checking email is vailid or not

  void VailidEmail(){
   final bool isEmail= EmailValidator.validate(emailController.text.trim());
   if (isEmail){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vailid email")));
   }else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("invailid email")));
   }
  }

  void login(){
    _auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
utils().ToastMessage(value.user!.email.toString());
    }).onError((error , stackTrace){
      debugPrint(error.toString());
      utils().ToastMessage(error.toString());

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: () async{
      SystemNavigator.pop();
      return true;

    },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("login"),
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
                    // onChanged: (value){
                    //   setState(() {
                    //     // isEmailCorrect = isEmail(value);
                    //   });
                    // },
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
             title:"login", ontap: (){
               if(_fromKey.currentState!.validate()){
                 login();
               }
           },
           ),
              const SizedBox(height: 30,),
              Row(
                children: [ Text  ("Don't have an account ?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  }, child: Text("Sign Up"))],

              ),
            ],
          ),
        ),
      ),
    );
  }
}
