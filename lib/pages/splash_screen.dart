import 'package:flutter/material.dart';
import 'package:login/firebase_services/splash_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: Text("NIMBUS",style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
