import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;

  final String productId;
  final double price;
  final int quantity;
  final String title;
  //new
  final String imageUrl;
  CartItem(this.id, this.productId, this.price, this.quantity, this.title,
      this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction){
        return showDialog(context: context,
            builder:(ctx) =>AlertDialog(
              title: Text('Are you shure?'),
              content: Text('do you want to remove this item from the cart'),
              actions: <Widget>[
                FlatButton(child: Text('No'),onPressed: (){
                  Navigator.of(context).pop(false);
                },),
                FlatButton(child:Text('Yes'),onPressed:(){
                  Navigator.of(context).pop(true);
                })
              ],
            ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Theme.of(context).accentColor,
                width: 70,
                height: 70,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //CircleAvatar(child: Padding(
            //  padding: const EdgeInsets.all(5.0),
            //  child: FittedBox(child: Text('\$$price')),
            //),
            //backgroundColor: Theme.of(context).accentColor,),

            title: Text(title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Provider.of<Cart>(context, listen: false)
                        .removeSingleItem(productId);
                  },
                  child: Container(
                    height: 20,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Icon(
                      Icons.remove,
                    ),
                    alignment: Alignment.center,
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$quantity ',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Cart>(context, listen: false)
                        .addSingleItem(productId);
                  },
                  child: Container(
                    height: 20,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Icon(
                      Icons.add,
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),

            subtitle:Column(children: <Widget>[
              Text('Price: \$$price'),

              Text('Total:\$${(price * quantity)}'),
            ],),
          ),
        ),
      ),
    );
  }
}
