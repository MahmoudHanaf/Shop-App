import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';

class CheckOutScreen extends StatefulWidget {
  final List<Map <String,dynamic>> productSelected ;
  const CheckOutScreen({Key? key,required this.productSelected}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
       elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Check Out ",
           style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
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

      body: widget.productSelected ==null ?
       Center(child: Text("No Data Selected"))
       :
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: 
          [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.productSelected.map((e) => 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          e['productName'], 
                          maxLines: 2,
                          ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("quantity :  ${e['quantity']}",
                               textAlign: TextAlign.center, 
                               style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: 5,),
                              Text("Price :  ${e['productPrice'] * e['quantity']}",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w600       
                                ),
                              textAlign: TextAlign.center,
                              ),

                          ]),
                        ),
                        leading: Container( 
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(e['productImage'] ),
                             fit: BoxFit.fitHeight,
                            )
                          ), 
                        ),
                        trailing: IconButton(
                          onPressed: ()
                          {
                            setState(() {
                              Provider.of<ProductProvider>(context,listen: false)
                              .removeProductFromCart(e['productId']);
                            });
                          },
                          icon: Icon(Icons.delete,),
                        ),
                      ),
                      Divider(height: 2,color: Colors.grey.shade400,)
                    ],
                  ),
                  ).toList()
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical:  15),
              child: Row(
                children: [
                  Text(
                    "Total Price :  \$ "+ Provider.of<ProductProvider>
                    (context,listen: false).getTotalPrice(),

                    style:TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 20,),
                   Expanded(
                  child: InkWell(
                    onTap: ()
                    {
                       Provider.of<ProductProvider>(context,listen: false).sendCardData(context);
                    },
                    child: Container(
                      width: 200,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15 ),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:15 ,vertical: 5),
                        child: Text(
                          'Check Out',
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

                ]
                ,),
            ),
          ],
         ),
       ),
    
    );
  }
}