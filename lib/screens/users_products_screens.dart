
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/products.dart';
import '../widjets/user_products_item.dart';
import '../widjets/app_drawer.dart';
import 'edit_product_screen.dart';

class UsersProductsScreen extends StatelessWidget {
  static const routeName='/user-products';
  Future<void>_refreshProducts(BuildContext context) async{
   await Provider.of<Products>(context,listen: false).fetchAndSetProducts(true);
  }


  @override
  Widget build(BuildContext context) {
   // final productsData=Provider.of<Products>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      appBar: AppBar(
        title: const Text('Your products'),

        elevation: 0,
        actions: <Widget>[
           IconButton(icon:const Icon(Icons.add_circle),
             color:Theme.of(context).accentColor ,iconSize: 40,
            onPressed: (){
           Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },)
        ],
      ),
      drawer:AppDrawer() ,
      body:FutureBuilder(
        future: _refreshProducts(context),
        builder:(ctx,snapshot)=> snapshot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator(),):RefreshIndicator(
          onRefresh: ()=>_refreshProducts(context),
          child: Consumer<Products>(
            builder:(ctx,productsData,_)=> Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(itemCount: productsData.items.length,
              itemBuilder:(_,i)=>Column(children: <Widget>[UserProductItem(
                id: productsData.items[i].id,
                title:productsData.items[i].title ,
                imageUrl:productsData.items[i].imageUrl ,),
                Divider()
              ],)),
            ),
          ),
        ),
      ) ,
    );
  }
}
