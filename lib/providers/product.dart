import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with  ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product({
    @required this.id,
    @required this.title,
     @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite=false
  });
  Future<void> toggleFavoriteStatus (String token,String userId)async{

    final  url = 'https://shop-application-4904a.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';

    final  oldStatus=isFavorite;

    isFavorite=!isFavorite;
    notifyListeners();
    try{
      final response=await http.put(
       url,body: json.encode(
        isFavorite,
      )
      );
      if(response.statusCode>=400){
        isFavorite=oldStatus;
        notifyListeners();
      }
    }catch(error){
      isFavorite=oldStatus;
      notifyListeners();
    }
  }
}