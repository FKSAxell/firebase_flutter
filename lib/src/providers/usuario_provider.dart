import 'dart:convert';
// import 'dart:html';

import 'package:firebase_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;



class UsuarioProvider {

  final String _firebaseToken = 'AIzaSyCa16wUOmh-PpwtP8aRe4AtReybUMv9-qU';

  final _prefs = new PreferenciasUsuario();

  Future<Map<String,dynamic>> nuevoUsuario(String email, String password) async {
    final authData ={
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final resp = await http.post(
      Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
      body: json.encode(authData)
    );

    Map<String,dynamic> decodedResp= json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')){
      _prefs.token=decodedResp['idToken'];
      return { 'ok' : true, 'token': decodedResp['idToken']};
    } else{
      return { 'ok' : true, 'mensaje': decodedResp['error']['message']};
    }

  }

  Future<Map<String,dynamic>>  login(String email, String password) async {

    final authData ={
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final resp = await http.post(
      Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
      body: json.encode(authData)
    );

    Map<String,dynamic> decodedResp= json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')){
      _prefs.token=decodedResp['idToken'];
      return { 'ok' : true, 'token': decodedResp['idToken']};
    } else{
      return { 'ok' : true, 'mensaje': decodedResp['error']['message']};
    }

  }


}