import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';



import '../../helper/snack_helper.dart';
import '../../models/product.dart';
import '../../provider/product_provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product ;
  const ProductDetails({Key? key,required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int  quantity=1 ;
   @override
  void initState() {
    init ();
    super.initState();
  }

  void init() {
    if (Provider.of<ProductProvider>(context, listen: false)
        .cartContainProduct(widget.product.id ?? 0)) {
      var value = Provider.of<ProductProvider>(context, listen: false)
          .productSelected
          .where((e) => e['productId'] == widget.product.id)
          .first['quantity'];

      setState(() {
        quantity = value;
      });
    } else {
      setState(() {
        quantity = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.product.title ??'No title',
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
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            Expanded(
              child: Container(
                    height:140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(widget.product.image!))
                    ),
                  ),
            ),
          
            Text(
              widget.product.title !,
              maxLines: 2,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),

            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: 
              [
                Text(
                  widget.product.category!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                  ),
                  ),
                Row(
                  children: 
                  [
                    Icon(
                      Icons.star,
                       color: Colors.yellow,
                      ),
                    Text(
                      widget.product.rating?.rate.toString() ??'',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "Information",
              maxLines: 2,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
             SizedBox(height: 5,),
             Text(
              widget.product.description!,
              maxLines: 4,   
              style: TextStyle(
                letterSpacing: .2,
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
            ),

             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 15),
               child: Row(
                children: [
                  Text(
                      "\$ "+(widget.product.price).toString() ,
                      maxLines: 2,   
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.green,
                      ),
                    ),
                  SizedBox(width: 10,),
                  Row(
                    children: 
                    [
                      IconButton(
                        onPressed: ()
                        {
                          if(quantity !=1){
                            if(Provider.of<ProductProvider>(context, listen: false)
                             .cartContainProduct(widget.product.id ?? 0))
                            {
                               
                                  setState(() {
                                   Provider.of<ProductProvider>(context, listen: false)
                                   .changeCartQuantity(widget.product.id!,quantity - 1);
                                   init();
                                  });
                                
                            }else{
                               setState(() {
                              quantity --;
                            });
                            }
                           
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                       Text(
                        "${quantity}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                       ),
                      IconButton(
                        onPressed: ()
                        {
                        if(Provider.of<ProductProvider>(context, listen: false)
                             .cartContainProduct(widget.product.id ?? 0))
                            {
                               
                                  setState(() {
                                   Provider.of<ProductProvider>(context, listen: false)
                                   .changeCartQuantity(widget.product.id!,quantity + 1);
                                   init();
                                  });
                                
                            }else{
                               setState(() {
                              quantity ++;
                            });
                            }
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: ()
                      {
                        onItmeClicked(widget.product ,quantity,context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15 ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:15 ,vertical: 5),
                          child: Text(
                            Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .cartContainProduct(
                                          widget.product.id ?? 0)
                                  ? '- Remove From Cart'
                                  :
                                   '+ Add To Card',
                             style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
               ),
             ), 
          ]
          ),
       ),
    );
  }
  
  void onItmeClicked(Product product, int quatity, BuildContext context) {
    if (Provider.of<ProductProvider>(context, listen: false)
        .cartContainProduct(product.id ?? 0)) {
      Provider.of<ProductProvider>(context, listen: false)
          .removeProductFromCart(product.id ?? 0);
      SnackHelper.showSnack(
          title: 'Product removed Successfully', context: context);
      setState(() {
        quantity = 1;
      });
    } else {
      // Add Logic
      var x = quantity;
      Provider.of<ProductProvider>(context, listen: false).addProductToCart({
        'productId': product.id ?? 0,
        'quantity': quantity,
        'productName': product.title,
        'productPrice': product.price,
        'productImage': product.image,
      });
      SnackHelper.showSnack(
          title: 'Product Added Successfully', context: context);
      setState(() {
        quantity = x;
      });
    }
  }

 

}