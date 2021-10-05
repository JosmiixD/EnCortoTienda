import 'package:en_corto_tienda/src/views/signup/loading_page.dart';
import 'package:en_corto_tienda/src/views/signup/login_page.dart';
import 'package:en_corto_tienda/src/views/signup/signup_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function( BuildContext )> appRoutes = {
  'loading'                 : ( _ ) => LoadingPage(),
  'login'                   : ( _ ) => LoginPage(),
  'signup'                  : ( _ ) => SignUpPage(),
};