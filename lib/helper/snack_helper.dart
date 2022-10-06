import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackHelper 
{
  static void showSnack(
    {
      required String title,
      required BuildContext context ,
    }
  )
  {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
      title ,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ), 
      ),
      backgroundColor: Colors.green,
       ));
  }
}