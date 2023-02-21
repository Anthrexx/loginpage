import 'dart:ffi';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color.fromARGB(254, 3, 0, 28),
          appBar: AppBar(
          
            backgroundColor: Color.fromARGB(254, 3, 0, 28),
            title: const Text('Profile',style: TextStyle(color: Color.fromARGB(254,121, 255, 249)),),
            centerTitle: true,
            leading: Column(children:[IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_outlined,size: 20,))] ),
            actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add_to_home_screen_rounded)),Padding(padding: EdgeInsetsDirectional.only(end: 10))],
      
            
          ),
            
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [Padding(padding: EdgeInsetsDirectional.only(end: 15)),const Text("Edit",style: TextStyle(color: Colors.white),),Spacer(),Text("LogOut",style: TextStyle(color: Colors.white)),Padding(padding: EdgeInsetsDirectional.only(end: 10)) ],),
                SizedBox(height: 25),
                Column(
                  children: [Container(height: 230,
                  width: 180,
                    child:Card(shape:OutlineInputBorder(borderRadius:BorderRadius.circular(10)),),
                  ),
                  ],
                ),
                SizedBox(height: 10,),
                Text("FUll name",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600,fontSize: 18)),
                SizedBox(height: 10,),
                Text("@username",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w300,fontSize: 14)),
                SizedBox(height: 20,),
               Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                InkWell(onTap: (){},
                 child: Container(
                  decoration: BoxDecoration(color: Colors.amber),
                  height: 30,
                  width: 30,
                 ),
               ),
               SizedBox(width: 10,),
               InkWell(onTap: (){},
                 child: Container(
                   decoration: BoxDecoration(color: Colors.amber),
                    height: 30,
                    width: 30,
                   ),
               ),
               SizedBox(width: 10,),
              
               InkWell( onTap: (){},
                 child: Container(
                   decoration: BoxDecoration(color: Colors.amber),
                    height: 30,
                    width: 30,
                   ),
               ),
               ],),
               SizedBox(height: 8,),
              Text("Roll no",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w300,fontSize: 14)),
              SizedBox(height: 8,),
             
            Row(children: [ Padding(padding:EdgeInsetsDirectional.only(end: 40)),Text("20",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500,fontSize: 20)),Spacer(),Container(
                   decoration: BoxDecoration(color: Colors.amber),
                    height: 30,
                    width: 30,
                   ),  Padding(padding:EdgeInsetsDirectional.only(end: 40)),],
                   ),
                   SizedBox(height: 7,),
                     Row(children: [ Padding(padding:EdgeInsetsDirectional.only(end: 40)),Text("Post",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500,fontSize: 20)),Spacer(), Text("7",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500,fontSize: 20)),Padding(padding:EdgeInsetsDirectional.only(end: 45)),],) 
                //  ,GridView.builder(
                //  itemCount:29 ,
                //    gridDelegate: ,
                //    itemBuilder: (BuildContext context, int index) {  },
                //    child: Container(
                //        height:190,
                //        width: 150,
                //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                //           child: Image.asset("assets/image22.png")),
                //  ),
                  ],
              
            ),
          ),
      ),
    );
  }
}