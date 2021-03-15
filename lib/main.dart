import 'package:firebase_flutter/src/pages/producto_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/src/bloc/provider.dart';
import 'package:firebase_flutter/src/pages/home_page.dart';
import 'package:firebase_flutter/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'login'    : (BuildContext context) => LoginPage(),
          'home'     : (BuildContext context) => HomePage(),
          'producto' : (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
  }
}