import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/screens/orders_screen.dart';
import 'package:provider/provider.dart';
import '../screens/users_products_screens.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child:Column(children: <Widget>[
        SizedBox(height: 40,),

        ListTile(
          leading: Icon(Icons.shop,color: Theme.of(context).accentColor,),
          title: Text('shop',style: TextStyle(fontSize: 20),),
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },


        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment,color: Theme.of(context).accentColor,),
          title: Text('Orders',style: TextStyle(fontSize: 20)),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          },


        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit,color: Theme.of(context).accentColor,),
          title: Text('Manage product',style: TextStyle(fontSize: 20)),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(UsersProductsScreen.routeName);
          },


        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app,color: Theme.of(context).accentColor,),
          title: Text('Logout',style: TextStyle(fontSize: 20)),
          onTap: (){
            Navigator.of(context).pop();//to close drawer to avoiding error
         Provider.of<Auth>(context,listen: false).logout();
           // Navigator.of(context).pushReplacementNamed(UsersProductsScreen.routeName);
          },


        ),


      ],) ,);
  }
}
