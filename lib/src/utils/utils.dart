import 'package:flutter/material.dart';
bool isNumeric (String s){

  if(s.isEmpty) return false;
  final n=num.tryParse(s);
  return (n == null) ? false : true ;

}

void mostrarAlerta(String mensaje,BuildContext context){

  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title:Text('ALERTA'),
        content: Text(mensaje),
        actions: [
          TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Ok'))
        ],
      );
    }
  );

}