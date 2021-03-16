import 'dart:io';

import 'package:firebase_flutter/src/models/producto_model.dart';
import 'package:firebase_flutter/src/providers/productos_provider.dart';
import 'package:firebase_flutter/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey= GlobalKey<FormState>();
  // final scaffoldKey= GlobalKey<ScaffoldState>();
  final productoProvider = new ProductosProvider();
  bool _guardando = false;


  ProductoModel producto = new ProductoModel();

  File foto;

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if(prodData !=null){
      producto=prodData;
    }

    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title:Text("Producto"),
        actions: [
          IconButton(icon: Icon(Icons.photo_size_select_actual), 
            onPressed: () => _seleccionarfoto(ImageSource.gallery),
          ),
          IconButton(icon: Icon(Icons.camera_alt), 
            onPressed:() => _tomarfoto(ImageSource.camera),
          ),
          
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
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
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),

      onSaved: (value){ 
        producto.titulo=value;
      },

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
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value){ 
        producto.valor=double.parse(value);
      },
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
        onPressed: ( _guardando ) ? null : _submit, 
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

  _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible, 
      title: Text("Disponible"),
      activeColor: Colors.deepPurple,
      onChanged: (value){
        producto.disponible=value;
        setState(() { });
      }
    );
  }

  void _submit() async {
    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();
    // print(producto.titulo);
    // print(producto.valor);
    // print(producto.disponible);
    setState(() { _guardando=true; });

    if(foto!=null){
      producto.fotoUrl = await productoProvider.subirImagen(foto);
    }
    if(producto.id==null){
      productoProvider.crearProducto(producto);
    }else{
      productoProvider.editarProducto(producto);
    }
    setState(() { _guardando=false; });
    ScaffoldMessenger.of(context).showSnackBar(_mostrarSnackbar("Registro Guardado"));
    Navigator.pop(context);
  }

  Widget _mostrarSnackbar(String mensaje){
     return SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    

  }


 _mostrarFoto() {
 
    if (producto.fotoUrl != null) {
      return Container();
    } else {
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  void _seleccionarfoto(ImageSource origin) async {

    final _picker = ImagePicker();
 
    final pickedFile = await _picker.getImage(
      source: origin,
    );
    
    if(pickedFile == null) return;

    foto = File(pickedFile.path);
 
    if (foto != null) {
      producto.fotoUrl = null;
    }
 
    setState(() {});
  
  }

  void _tomarfoto(ImageSource origin) async {

    final _picker = ImagePicker();
 
    final pickedFile = await _picker.getImage(
      source: origin,
    );
    
    if(pickedFile == null) return;

    foto = File(pickedFile.path);

    if (foto != null) {
      producto.fotoUrl = null;
    }

    setState(() {});


  }

}