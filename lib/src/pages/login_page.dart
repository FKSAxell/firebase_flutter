import 'package:firebase_flutter/src/providers/usuario_provider.dart';
import 'package:firebase_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/src/bloc/login_bloc.dart';
import 'package:firebase_flutter/src/bloc/provider.dart';
class LoginPage extends StatelessWidget {

  
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     body: Stack(
       children: [
         _crearFondo(context),
         _loginForm(context),
       ]
     )
    );
  }

  _crearFondo(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: [
        fondo,
        Positioned(
          top: 270.0,
          child: circulo
        ),
        Positioned(
          top: 160.0,
          left: 350.0,
          child: circulo
        ),
        Positioned(
          top: 10.0,
          left: 130,
          child: circulo
        ),

        Container(
          height: size.height * 0.4,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon( Icons.person_pin_circle, color:Colors.white, size:80 , ),
              SizedBox( height:20.0 ),
              Text( "Youtube Piogram", style: TextStyle(color: Colors.white, fontSize: 20) )
            ],
          ),
        )
        
      ],
    );

  }

  _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;



    return SingleChildScrollView(
     
      child: Column(
        children: [

          SafeArea(
            child: Container(height: size.height*0.3)
          ),


          Container(
            // margin:EdgeInsets.symmetric(horizontal: size.width*0.10, vertical: size.height*0.3),
            width: size.width*0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                Text("Ingreso", style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 40.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc)
              ],
            ),
            
          ),
        

          Container( 
            padding: EdgeInsets.only(top:10.0), 
            child: TextButton(
              onPressed: ()=> Navigator.restorablePushReplacementNamed(context, 'registro'), 
              child: Text('Crear una nueva cuenta',
              style: TextStyle(color:Colors.deepPurple),))
          ),
          
          // SizedBox(height: 100.0,)
        ],
      ),
    ) ;  

  }

  _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon:Icon(Icons.alternate_email,color: Colors.deepPurple),
              hintText: "ejemplo@correo.com",
              labelText: "Correo Electrónico",
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: (value)=> bloc.changeEmail(value)
            ,
          ),
        );
      },
    );
    
    
  }

  _crearPassword(LoginBloc bloc) {


    return StreamBuilder(
      stream: bloc.passwordStream,
      builder:(BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon:Icon(Icons.lock_outline,color: Colors.deepPurple),
              labelText: "Contraseña",
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: (value)=> bloc.changePassword(value),
          ),
        );
      } ,
    );
    
  }

  _crearBoton(LoginBloc bloc) {
    //formValidStream
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder:(BuildContext context, AsyncSnapshot snapshot){
        return TextButton(
          onPressed: snapshot.hasData ? (){_login(bloc,context);} : null, 
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 8.0),
            child: Text('Ingresar'),
          ),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.deepPurple,
            onSurface: Colors.white,
            elevation: 0.0
          ),
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context ) async {
    // print('===========');
    // print('Email ${bloc.email}');
    // print('Password: ${bloc.password} ');
    // print('===========');

    Map info = await usuarioProvider.login(bloc.email, bloc.password);
    if(info['ok']){
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      mostrarAlerta(info['mensaje'],context);
    }
  }

}