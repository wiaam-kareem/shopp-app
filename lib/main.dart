import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/providers/cart.dart';
import 'package:flutter_app/providers/orders.dart';
import 'package:flutter_app/screens/cart_screen.dart';
import 'package:flutter_app/screens/products_overview_screen.dart';
import 'package:flutter_app/screens/splash_screen.dart';
import 'package:flutter_app/screens/users_products_screens.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
     providers: [
       ChangeNotifierProvider.value(value: Auth()),
       ChangeNotifierProxyProvider<Auth,Products>(
    builder:(ctx,auth,previousProducts)=>Products(
        auth.token,previousProducts==null?[]:previousProducts.items,auth.userId)
    ),
       ChangeNotifierProvider.value(value: Cart()),

       ChangeNotifierProxyProvider<Auth,Orders>(
         builder:(ctx,auth,previousOrders,)=> Orders(
             auth.token,previousOrders==null?[]:previousOrders.orders,auth.userId),)

     ],
      child:Consumer<Auth>(builder: (ctx,auth,_)=> MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            backgroundColor:Color.fromRGBO(223, 228, 234,1.0) ,
            primaryColor:Color.fromRGBO(223, 228, 234,1.0),
            accentColor:Color.fromRGBO(236, 204, 104,1.0),
            fontFamily:'RobotoCondensed'
        ),
        home:auth.isAuth? ProductsOverviewScreen():FutureBuilder(
          future:auth.tryAutoLogin(),
          builder:(ctx,authResultSnapshot) => authResultSnapshot.connectionState==ConnectionState.waiting?SplashScreen():AuthScreen()),

        routes: {
          ProductDetailScreen.routeName:(ctx) =>ProductDetailScreen(),
          CartScreen.routeName:(ctx)=>CartScreen(),
          OrdersScreen.routeName:(ctx)=>OrdersScreen(),
          UsersProductsScreen.routeName:(ctx)=>UsersProductsScreen(),
          EditProductScreen.routeName:(ctx)=>EditProductScreen()
        },
      )),
    );
  }
}

