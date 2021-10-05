import 'package:en_corto_tienda/src/routes/routes.dart';
import 'package:en_corto_tienda/src/theme/constants.dart';
import 'package:en_corto_tienda/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => AuthService())
      ],
      child: MaterialApp(
        title: 'En Corto - Tienda',
        debugShowCheckedModeBanner: false,
        routes: appRoutes,
        initialRoute: 'login',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: nixEnCortoPrimaryColor,
          accentColor: nixEnCortoPrimaryColor,
          primaryTextTheme: TextTheme(
            headline6: TextStyle( color: Colors.black )
          ),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData( color: Colors.black ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white
          ),
          textTheme: ThemeData.light()
            .textTheme
            .apply( fontFamily: 'Poppins' )
        ),
      ),
    );
  }
}
