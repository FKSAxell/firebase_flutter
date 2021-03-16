import 'dart:convert';

import 'package:firebase_flutter/src/models/producto_model.dart';
import 'package:flutter/material.dart' ;
import 'package:http/http.dart' as http;
class ProductosProvider{

  final String _url ='https://udemy-productos-flutter-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async{

    final url  = '$_url/productos.json';
    final resp = await http.post( Uri.parse(url), body: productoModelToJson(producto) );


    final decodeData = json.decode(resp.body);

    print( decodeData );
    
    return true;
  }






}