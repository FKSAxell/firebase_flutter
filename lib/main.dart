import 'package:firebase_flutter/src/pages/producto_page.dart';
import 'package:firebase_flutter/src/pages/registro_page.dart';
import 'package:firebase_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/src/bloc/provider.dart';
import 'package:firebase_flutter/src/pages/home_page.dart';
import 'package:firebase_flutter/src/pages/login_page.dart';
 
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized(); 
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    final rutaInicial= (prefs.token.length > 0)
                        ? 'home'
                        : 'login'
                        ;

    return Provider(
        child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: rutaInicial,
        routes: {
          'login'    : (BuildContext context) => LoginPage(),
          'home'     : (BuildContext context) => HomePage(),
          'producto' : (BuildContext context) => ProductoPage(),
          'registro' : (BuildContext context) => RegistroPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
  }
}