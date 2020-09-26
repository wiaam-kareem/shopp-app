import 'package:flutter/material.dart';
import 'package:flutter_app/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  //final String title;
  //ProductDetailScreen(this.title);
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(

      backgroundColor: Theme.of(context).backgroundColor,
//      appBar: AppBar(
//
//        title: Text(loadedProduct.title),
//        elevation: 0.0,
//      ),
      body: CustomScrollView(
         slivers: <Widget>[
           SliverAppBar(
             expandedHeight: 300,
             pinned: true,
             flexibleSpace: FlexibleSpaceBar(
               titlePadding: EdgeInsets.only(left: 10.0),
               title: Container(

                   child: Text(loadedProduct.title)),

               background:  Hero(

                   tag:loadedProduct.id ,
                   child: Image.network(loadedProduct.imageUrl,fit: BoxFit.cover,)),

             ),
           ),
         SliverList(delegate: SliverChildListDelegate([
           SizedBox(height: 30,),
           Text('\$${loadedProduct.price}',
             textAlign: TextAlign.center,
             style: TextStyle(color: Colors.redAccent,
                 fontSize: 20,fontWeight: FontWeight.bold),
           ),
           SizedBox(height: 10,),
           Container(
             width: double.infinity,
             padding: EdgeInsets.symmetric(horizontal: 10),
             child: Text(
               loadedProduct.description,
               textAlign: TextAlign.center,
               softWrap: true,),
           ),
           SizedBox(height:800 ,),
         ]))
         ],

      ),
    );
  }
}
