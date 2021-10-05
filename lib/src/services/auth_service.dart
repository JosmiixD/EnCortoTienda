import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {

  bool _authenticating = false;


  //BEGIN:: Form Information
  String ownerName;
  String ownerLastName;
  String email;
  String password;
  String passwordConfirmation;
  String phone;

  //BEGIN:: BUSINESS INFORMATION
  String businessName;
  String businessAddress;
  String latlng;
  //END:: BUSINESS INFORMATION
  
  //END:: Form Information

  bool get authenticating => this._authenticating;
  set authenticating( bool value ) {
    this._authenticating = value;
    notifyListeners();
  }

  void disposeForm() {
    ownerName = null;
    ownerLastName = null;
    email = null;
    password = null;
    passwordConfirmation = null;
    phone = null;
  }

}