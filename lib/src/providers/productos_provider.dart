import 'dart:convert';
import 'dart:io';

import 'package:firebase_flutter/src/models/producto_model.dart';
// import 'package:flutter/material.dart' ;
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
class ProductosProvider{

  final String _url ='https://udemy-productos-flutter-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async{

    final url  = '$_url/productos.json';
    final resp = await http.post( Uri.parse(url), body: productoModelToJson(producto) );


    final decodeData = json.decode(resp.body);

    print( decodeData );
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

  Future<String> subirImagen(File imagen) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dxe8ux2yd/image/upload?upload_preset=g8j4hrzy');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType(mimeType[0],mimeType[1])
    );

    imageUploadRequest.files.add(file);
    //se pueden agregar más

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode !=200 && resp.statusCode != 201){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    final respData= json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }






}