import 'package:firebase_flutter/src/models/producto_model.dart';
import 'package:firebase_flutter/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        onPressed: ()=>Navigator.pushNamed(context, "producto")
                        .then((value) => setState((){})),
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
        productosProvider.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: [

            ( producto.fotoUrl==null )
              ? Image(image:AssetImage('assets/no-image.png'))
              : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'), 
                image: NetworkImage(producto.fotoUrl),
                height: 300.0,
                width: double.infinity,
                fit:BoxFit.cover,
              ),
               ListTile(
                title: Text('${ producto.titulo } - ${ producto.valor }'),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, "producto", arguments: producto)
                              .then((value) => setState((){})),
              ),

          ],
        ),
      )
    );


    

  }
}