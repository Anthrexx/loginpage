import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final fullname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 0, 28),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 0, 28),
        centerTitle: true,
        title: (const Text("Edit Profile",
            style: TextStyle(
              color: Color.fromARGB(254, 121, 255, 249),
            ))),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: fullname,
                    cursorColor: const Color.fromARGB(255, 255, 255, 255),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            color: Color.fromARGB(254, 42, 69, 73),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: Color.fromARGB(77, 217, 217, 217),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: fullname,
                    cursorColor: const Color.fromARGB(255, 255, 255, 255),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            color: Color.fromARGB(254, 42, 69, 73),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: Color.fromARGB(77, 217, 217, 217),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: fullname,
                    cursorColor: const Color.fromARGB(255, 255, 255, 255),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Roll no',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            color: Color.fromARGB(254, 42, 69, 73),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: Color.fromARGB(77, 217, 217, 217),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: fullname,
                    cursorColor: const Color.fromARGB(255, 255, 255, 255),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            color: Color.fromARGB(254, 42, 69, 73),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: Color.fromARGB(77, 217, 217, 217),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: fullname,
                    cursorColor: const Color.fromARGB(255, 255, 255, 255),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Instagram Id',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            color: Color.fromARGB(254, 42, 69, 73),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: Color.fromARGB(77, 217, 217, 217),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(height: 50,),
                SizedBox(
              height: 45,
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(254, 28, 111, 125),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: (() {
                    
                  }),
                  child: const Center(
                    child: SizedBox(
                      width: 43,
                      height: 19,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Save',
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
          ),
        ),
      ),
    );
  }
}
