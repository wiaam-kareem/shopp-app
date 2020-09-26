
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/widjets/product_item.dart';
import 'package:flutter_app/providers/product.dart';


class  ProductsGrid extends StatelessWidget {
  final bool showFavs;

 ProductsGrid( this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData=Provider.of<Products>(context);
    final products=showFavs?productsData.favoritItems:productsData.items;
    return GridView.builder(
      
        padding:const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (ctx,i) =>ChangeNotifierProvider.value (
          value: products[i],
           // builder: (c)=>products[i],
            child: ProductItem(
           // products[i].id,
           // products[i].title,
            //products[i].imageUrl

     ))
    );
  }
}