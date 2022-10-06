import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/views/widgets/product_card.dart';

import '../../provider/product_provider.dart';

class ShowProducts extends StatelessWidget {
 final  List<Product>? products ;
  const ShowProducts({Key? key,required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: products == null ?
                  Center(child: CircularProgressIndicator(),)
                  :
                  products!.isEmpty ?

                    Center(child: Text("No Data Found ..... please referesh app"),)
                  :

                  Wrap(
                    spacing: 15, // btween
                    runSpacing: 10, // top and bottom
                  children :
                   products!.map((e)=>ProductCard(product: e,)).toList()
                    
                    ),
    );
    
  }
}