import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  bool get isAuth {
    return token != null;
  }
String get userId{
    return _userId;
}
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authinticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBrAMKqhEk8p6-w0i8VcfDfBp3coxxDlnE';
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();
      final userData=json.encode({
        'token':_token,
          'userId':_userId,
           'expiryData':_expiryDate.toIso8601String(),
      });
      //shared preferences is to store data in devise storage
    final prefs=await SharedPreferences.getInstance();
    prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authinticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authinticate(email, password, 'signInWithPassword');
  }
  Future<bool>tryAutoLogin()async{
   final prefs=await SharedPreferences.getInstance();
   if(!prefs.containsKey('userData')){return false;}

   final extractedUserData=json.decode(
       prefs.getString('userData')) as Map<String,Object>;
   final expiryDate=DateTime.parse(extractedUserData['expiryData']);
  if(expiryDate.isBefore(DateTime.now())){
    return false;
  }
  _token=extractedUserData['token'];
  _userId=extractedUserData['userId'];
  _expiryDate=expiryDate;
  notifyListeners();
  _autoLogout();
  return true;

  }
  void logout() async{
    _token=null;
    _userId=null;
    _expiryDate=null;
    //cancel the existing timer when logout
    if(_authTimer!=null) {
      _authTimer.cancel();
      _authTimer=null;
    }

    notifyListeners();
    //clear device local storage
    final prefs=await SharedPreferences.getInstance();
    //prefs.remove('userData');when i want to remove specific data
    prefs.clear();
    
  }
  void _autoLogout(){
    //if we already have an existing timer we should cancel before i start in new one
    if(_authTimer!=null){
      _authTimer.cancel();
    }
    final timeToExpiry=_expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer=Timer(Duration(seconds:timeToExpiry,),logout);
  }
}
