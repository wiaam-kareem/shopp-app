import 'package:flutter/material.dart';
import 'package:flutter_app/providers/products.dart';
import 'package:flutter_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem({this.id,this.title,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold=Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width:100 ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,

          children: <Widget>[
          IconButton(icon:Icon(Icons.edit),onPressed:(){
            Navigator.of(context).pushNamed(EditProductScreen.routeName,
           arguments:  id);
          },color: Theme.of(context).accentColor,iconSize: 20,),
          IconButton(icon:Icon(Icons.delete_forever),onPressed:()async{
            try {
             await Provider.of<Products>(context, listen: false).deleteProduct(id);
            }catch(error){
              scaffold.showSnackBar(
                  SnackBar(content: Text('Deleting failed')));
            }
          },color: Colors.redAccent,iconSize: 20,),


        ],
        ),
      ),

    );

  }
}
