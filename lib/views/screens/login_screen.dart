import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:shop_app/services/app_service.dart';
import 'package:shop_app/views/screens/register_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fromKey  =GlobalKey<FormState>();
  late TextEditingController nameController =TextEditingController();
  late TextEditingController emailController =TextEditingController();
  late TextEditingController passwordController =TextEditingController();
  bool observe = true ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar:AppBar(
        title: Text("LogIn Screen"),
        centerTitle: true,
      ),
       
       body: Center(
         child: Form(
          key: fromKey,
           child: SingleChildScrollView(
             child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                
                Card(
                  child: Image.asset(
                    "assets/logo2.png",
                     height: 100,
                     fit: BoxFit.fitWidth,
                    ),
                ), 
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 15),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                    // hintText: "Email",
                    label:Text("Enter Your Email",
                    style: 
                    TextStyle(fontSize: 16),
                    ),
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.grey,),
           
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    validator: (value)
                    {
                      if(value!.isEmpty )
                      {
                        return "Please Enter Your Email";
                      }
                      return null ;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 15),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: observe,
                    decoration: InputDecoration(
                    label:Text("Enter Your Password",
                    style: 
                    TextStyle(fontSize: 16),
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          observe =!observe ;
                        });
                      },
                      icon: observe == true ? 
                      Icon(Icons.visibility_off,)
                      :
                       Icon(Icons.visibility,),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    validator: (value)
                    {
                      if(value!.isEmpty )
                      {
                        return "Please Enter Your Password";
                      }
                      return null ;
                    },
                  ),
                ),
                SizedBox(height: 22,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    width: double.infinity,
                    
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(5),
                      color: Colors.green,
                       ),
                   
                    child: MaterialButton(
                      onPressed: ()
                      {
                         onLogin();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          ),
                      ),
           
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    Text(
                      "Don't Have an Account ??",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: ()
                        {
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                             );
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blue),
                          ),
                      ),
                  ],
                  ),
              ]
              ),
           ),
         ),
       ),
      );
  }

 Future  onLogin() async
 {
   if(fromKey.currentState!.validate())
   {
      showFutureLoadingDialog(context: context ,future: ()=>SaveData());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) => HomeScreen(),),(route)=>false);

    
   }
    
 }

 Future SaveData () async
 {
   await AppService.prefs?.setString("email",emailController.text);
   await AppService.prefs?.setString("password",passwordController.text);
 }

}