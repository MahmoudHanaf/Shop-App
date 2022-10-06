// import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/services/app_service.dart';
import 'package:shop_app/views/screens/login_screen.dart';

import 'home_screen.dart';


class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

 @override
  void initState() {
     init();
    super.initState();
  }

  void init()
  {
    Future.delayed(Duration(seconds: 1),() =>toScreen() );
    
  }
  
 Future <void> toScreen () async
  {
    if(AppService.prefs!.getString("email") != null)
    {
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) => HomeScreen(),),(route)=>false);
    }else 
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        );
    }
    
      
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
         body: Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              Image.asset(
                "assets/logo.png",
                height: 180,
                width: 180,
                fit: BoxFit.contain,
                ) ,
                SizedBox(height: 10,),
                Text(
                  "Online Shoping",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                  ),
                  ),
                  SizedBox(height: 15,),
               CircularProgressIndicator(),
                  
            ]
            ),
         ),
      ) ;
  }
}