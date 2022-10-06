import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/views/screens/product_details.dart';

import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product ;
  const ProductCard({Key? key,required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ),
        );
      },
      child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Container(
                  width: 140,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
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
                              image: DecorationImage(image: NetworkImage(product.image ?? ''))
                            ),
                           ),
                         ),
                         SizedBox(height: 10,),
                        Text(
                          "${product.title}",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey
                          ),
                          ),
    
                           Text(
                          "\$ "+(product.price).toString(),
                        
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.amber[900]                        ),
                          ),
                      ]),
                  ),
                ),
              ),
    );
         
  }
}