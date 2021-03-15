import 'package:firebase_flutter/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Producto"),
        actions: [
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: (){}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: (){}),
          
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
                SizedBox(height: 20.0,),
                _crearBoton(),
              ],
            )
          ),
        ),
      )

    );
  }

  _crearNombre() {

    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      validator: (value){
        if(value.length <3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );

  }

  _crearPrecio() {
    
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      validator: (value){
        
        if (utils.isNumeric(value)){
          return null;
        }else{
          return 'Solo números';
        }

      },
    );

  }

  _crearBoton() {

    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: TextButton(
        onPressed: _submit, 
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 8.0),
          child: Text('Guardar'),
        ),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.deepPurple,
          onSurface: Colors.white,
          elevation: 0.0,         
        ),
      ),
    );

  }

  void _submit(){
    if(!formKey.currentState.validate()) return;
    print('Todo OK!');
  }
}