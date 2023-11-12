 
import 'package:app/modules/authentication/Login/bloc/login_bloc.dart';
import 'package:app/modules/authentication/Login/login_page.dart';
import 'package:app/modules/authentication/otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/items/items_page.dart';

abstract class Router {
  static String home = "/";
  static String items = "/items";

  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      // home: (context) =>  EmailOtp(userEmail: 'rifad@cybersquare.org',),
      home: (context) =>  LoginScreen(),

      items: (context) => ItemsPage(),
    };
  }
}
