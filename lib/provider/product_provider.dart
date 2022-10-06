import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:shop_app/helper/snack_helper.dart';
import 'package:shop_app/views/screens/home_screen.dart';

import '../models/Card.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl ;

class ProductProvider extends ChangeNotifier
{
  List <Map <String, dynamic>> categoriesData =
  [
    {
      "title": "electronics",
      "image" : "assets/electronics.png",
    },
    {
      "title": "jewelery",
      "image" : "assets/jewel.png",
    },
    {
      "title": "men's clothing",
      "image" : "assets/menclothes.png",
    },
    {
      "title": "women's clothing",
      "image" : "assets/womenclothes.png",
    },
  ]; 

   
   List <Product> ? _homeProducts ;
   List <Product>? get homeProducts => _homeProducts;
   void getHomePageProducts () async
   {  
       try 
       {
         var response = await http.get(Uri.parse("https://fakestoreapi.com/products?limit=6"))
         .timeout(Duration(seconds: 12));
 
          if(response.statusCode ==200)
          {
            _homeProducts =List<Product>.from(jsonDecode(response.body)
            .map((e)=> Product.fromJson(e)));

          }else
          {
            _homeProducts =[];
          }
           notifyListeners();
       }catch(e)
       {
          _homeProducts =[];
          notifyListeners();
          print(e);
       }
   }

   List <Product> ? _allProducts ;
   List <Product>? get allProducts => _allProducts;
   void getAllPageProducts () async
   {  
       try 
       {
         var response = await http.get(Uri.parse("https://fakestoreapi.com/products"))
         .timeout(Duration(seconds: 12));
 
          if(response.statusCode ==200)
          {
            _allProducts =List<Product>.from(jsonDecode(response.body)
            .map((e)=> Product.fromJson(e)));
          }else
          {
            _allProducts =[];
          }
           notifyListeners();
       }catch(e)
       {
          _allProducts =[];
          notifyListeners();
          print(e);
       }
   }

   List <Product> ? _categoryProducts ;
   List <Product>? get categoryProducts => _categoryProducts;
   void getCategoryProducts ({required String categoryTitle }) async
   {  

       if(_categoryProducts !=null) clearCategoryList(); 
       try 
       {
         var response = await http.get(Uri.parse("https://fakestoreapi.com/products/category/${categoryTitle}"))
         .timeout(Duration(seconds: 12));
 
          if(response.statusCode ==200)
          {
            _categoryProducts =List<Product>.from(jsonDecode(response.body)
            .map((e)=> Product.fromJson(e)));
          }else
          {
            _categoryProducts =[];
          }
           notifyListeners();
       }catch(e)
       {
          _categoryProducts =[];
          notifyListeners();
          print(e);
       }
   }
   

   void clearCategoryList ()
   {
    WidgetsFlutterBinding.ensureInitialized();
     WidgetsBinding.instance.addPostFrameCallback ((timeStamp){
        _categoryProducts =null;
        notifyListeners();
     },);
   }
  

   List <Map<String,dynamic>>  productSelected =[];
  
  void addProductToCart(Map<String, dynamic> valueSelected) {
    productSelected.add(valueSelected);
    notifyListeners();
  }


   void removeProductFromCart(int productId) {
    productSelected.removeWhere((element) => element['productId'] == productId);
    notifyListeners();
  }

    bool cartContainProduct(int productId) {
    var result = productSelected
       .where((element) => element['productId'] == productId)
        .toList();
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String getTotalPrice (){
    double totalPrice =0;
    for(var product in productSelected )
    {
      totalPrice +=product['productPrice'] * product['quantity'];
    }
    return totalPrice.toString();
  }

  void sendCardData (BuildContext context) async
  {
     productSelected = productSelected.map((e) =>{
      'productId' : e['productId'].toString(),
      'quantity' : e['quantity'].toString(),
     },).toList();
 
     var response = await showFutureLoadingDialog(
      context: context ,
      future:()=> http.post(Uri.parse("https://fakestoreapi.com/carts"),
       body: jsonEncode({
        "userId" : 5,
        "date": intl.DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "products" :productSelected ,
       })
      )
     );

     if(response.result?.statusCode ==200)
     {
       productSelected = [];
       notifyListeners();
       SnackHelper.showSnack(context: context,title: "Order Send Successfully ");
       Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route)=> false ,
       );
     }

  }

 void changeCartQuantity (int productId ,int newQuantity){
     var productModified = productSelected.where((e) => 
     e['productId'] == productId,).first;
     
     productModified ['quantity']= newQuantity ;
     productSelected.removeWhere((e) =>e['productId'] == productId ,);
     productSelected.add(productModified);
     notifyListeners();
 }

}