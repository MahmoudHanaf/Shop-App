import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/views/screens/all_products.dart';
import 'package:shop_app/views/screens/check_out_screen.dart';
import 'package:shop_app/views/widgets/category_card.dart';
import 'package:shop_app/views/widgets/product_card.dart';
import 'package:shop_app/views/widgets/show_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() { 
    Provider.of<ProductProvider>(context,listen: false).getHomePageProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Home",
           style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
            ),
          ),

          actions: 
          [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Provider.of<ProductProvider>(context).productSelected !=[] ?
              Badge(
                position: BadgePosition.topStart(),
                badgeContent: Text(
                  Provider.of<ProductProvider>(context).productSelected.length.toString(),
                  style: TextStyle(
                    color: Colors.white ,
                  ),
                  ),
                  
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                          CheckOutScreen(productSelected:Provider.of<ProductProvider>
                          (context).productSelected ),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_outlined, color: Colors.black,),
                    ),
              )

              :
              IconButton(
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                          CheckOutScreen(productSelected:Provider.of<ProductProvider>
                          (context).productSelected ),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,),
                    ),
          ),
           

          ],
      ) ,
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
            children: 
            [
              Container(
                height:180,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/discount.jpg"))
                ),
              ),
       
              Row(
                children: 
                [
                 Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                    ),
                  ),
                ],),
              SizedBox(height: 10,),
       
              SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Provider.of<ProductProvider>(context,listen: false)
                  .categoriesData.map((e) => 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoryCard(title: e['title'],image: e['image'],),
                  ))
                  .toList(),
                  ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: 
                [
                 Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                    ),
                  ),

                  InkWell(
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:  (context) => AllProducts(),
                        ),
                      );
                    },
                    child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800]
                      ),
                    ),
                  ),
                ],),
                SizedBox(height: 10,),

                ShowProducts(products: Provider.of<ProductProvider>(context).homeProducts,)
            ]
            ),
         ),
       ),


      );
  }
}