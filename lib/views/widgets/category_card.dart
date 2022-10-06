import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/views/screens/all_products.dart';

class CategoryCard extends StatelessWidget {
  final String title ;
  final String image ;
  const CategoryCard({Key? key,required this.title, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllProducts(categoryTitle: title),
          )
        );
      },
      child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Container(
                  width: 85,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255,253,252,252),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: 
                      [
                         Expanded(
                           child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(image))
                            ),
                           ),
                         ),
                         SizedBox(height: 5,),
                        Text(
                          "${title}",
                          textAlign: TextAlign.center,
                          ),
                      ]),
                  ),
                ),
              ),
    );
         
  }
}