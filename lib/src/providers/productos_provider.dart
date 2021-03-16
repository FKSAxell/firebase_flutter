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

    // print( decodeData );
    return true;
  }



  Future<bool> editarProducto(ProductoModel producto) async{

    final url  = '$_url/productos/${producto.id}.json';
    final resp = await http.put( Uri.parse(url), body: productoModelToJson(producto) );


    final decodeData = json.decode(resp.body);

    print( decodeData );
    return true;
  }



  Future<List<ProductoModel>>  cargarProductos() async{
    final url  = '$_url/productos.json';

    final resp = await http.get( Uri.parse(url));
    final Map<String,dynamic> decodeData = json.decode(resp.body);
    if (decodeData ==null ) return [];

    final List<ProductoModel> productosL=[];

    decodeData.forEach((id, prod) {
      final ProductoModel producto=  ProductoModel.fromJson(prod);
      producto.id = id;
      productosL.add(producto);
    });
    // print(productosL);
    return productosL;
  }

  Future<int> borrarProducto( String id ) async {
    final url  = '$_url/productos/$id.json';
    final resp = await http.delete(Uri.parse(url));
    print(resp.body);
    return 1;
  }






}