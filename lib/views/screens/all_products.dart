import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/views/widgets/show_products.dart';

class AllProducts extends StatefulWidget {
  final String? categoryTitle ;
  const AllProducts({Key? key,this.categoryTitle}) : super(key: key,);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    init ();
    super.initState();
  }

  void init()
  {
    if(widget.categoryTitle != null)
    {
      Provider.of<ProductProvider>(context,listen: false).getCategoryProducts(categoryTitle: widget.categoryTitle!);
    }else{
      Provider.of<ProductProvider>(context,listen: false).getAllPageProducts();
    }
   
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
       elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.categoryTitle != null? widget.categoryTitle! :
          "All Products",
           style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
            ),
          ),

          leading: IconButton(
            onPressed: ()
            {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
            widget.categoryTitle != null?
             ShowProducts(products: Provider.of<ProductProvider>(context).categoryProducts)
            :
             ShowProducts(products: Provider.of<ProductProvider>(context).allProducts),
          ),
        )

     );
  }
}