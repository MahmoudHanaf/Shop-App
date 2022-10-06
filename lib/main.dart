import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/services/app_service.dart';
import 'package:shop_app/views/screens/login_screen.dart';
import 'package:shop_app/views/screens/register_screen.dart';
import 'package:shop_app/views/screens/splach_screen.dart';

void main() {
  AppService.init();
  runApp( MultiProvider(
    providers: 
    [
      ChangeNotifierProvider(create: (context) => ProductProvider(),)
    ],
    child: MyApp()
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application. 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplachScreen(),
    );
  }
}

