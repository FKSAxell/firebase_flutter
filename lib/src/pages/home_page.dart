import 'package:firebase_flutter/src/models/producto_model.dart';
import 'package:firebase_flutter/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  final productosProvider = new ProductosProvider();  
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {

      return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, 'producto')
      );

  }

  _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData){
          final  productos = snapshot.data; 
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (BuildContext context, int i)=> _crearItem(productos[i],context),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _crearItem(ProductoModel producto, BuildContext context){

    return Dismissible(
      key:UniqueKey(),
      background: Container(color:Colors.red),
      onDismissed: (direction){
        // TODO: borrar despues

      },
      child: ListTile(

        title: Text('${ producto.titulo } - ${ producto.valor }'),
        subtitle: Text(producto.id),
        onTap: ()=> Navigator.pushNamed(context, 'producto'),

      ),
    );

  }


}