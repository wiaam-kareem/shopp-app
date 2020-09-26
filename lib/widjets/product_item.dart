import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/providers/cart.dart';
import 'package:flutter_app/providers/product.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  //final String id;
  //final String title;
  //final String imageUrl;
  //ProductItem(this.id,this.title,this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData=Provider.of<Auth>(context,listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child:Hero(
            tag: product.id,
            child: FadeInImage(
                placeholder: AssetImage('assets/images/placeholderimg.png'),
                image: NetworkImage(product.imageUrl),fit: BoxFit.cover,),
          )
        ),
        footer: GridTileBar(
          title: Text(product.title),
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavoriteStatus(authData.token,authData.userId);
                  },
                  color: Theme.of(context).accentColor,
                ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title,product.imageUrl);
              Scaffold.of(context).showSnackBar(SnackBar(
                content:Text('Added to cart seccesfully')  ,
                duration: Duration( seconds: 2),


              ),);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
