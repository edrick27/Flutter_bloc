import 'package:flutter/material.dart';
import 'package:patron_bloc/src/bloc/login_bloc.dart';
import 'package:patron_bloc/src/bloc/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context)
        ],
      )
    );
  }

  Widget _loginForm(context){

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      // controller: controller,
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric( vertical: 30.0 ),
            padding: EdgeInsets.symmetric( vertical: 50.0 ),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text("ingreso", style: TextStyle( fontSize: 20.0 )),
                SizedBox( height: 60.0 ),
                _crearEmail(bloc),
                SizedBox( height: 30.0 ),
                _crearPassword(bloc),
                SizedBox( height: 30.0 ),
                crearBoton(bloc)
              ],
            ),
          ),
          Text('¿ Olvido su contraseña?'),
          SizedBox( height: 100.0 )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon( Icons.alternate_email, color: Colors.deepPurple ),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error
              ),
              onChanged: (value) => bloc.ChangeEmail(value)
          )
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon( Icons.lock_outline, color: Colors.deepPurple ),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.ChangePassword
          )
        );
      }
    );
  }

  Widget crearBoton(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( horizontal: 100.0, vertical: 20.0),
            child: Text('Ingresar')
          ),
          onPressed: (!snapshot.hasData) ? null : () => _login(bloc, context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
        );
      },
    );
  }


  _login(LoginBloc bloc, BuildContext context) {

    Navigator.pushReplacementNamed(context,'home');
    print("================");
    print("email ${bloc.email}");
    print("================");
    print("PassWord ${bloc.password}");
  }

  Widget _crearFondo(context){

    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 71, 178, 1.0),
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    final logo = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: <Widget>[
          Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
          SizedBox( height: 10.0, width: double.infinity),
          Text("Login", style: TextStyle(color: Colors.white, fontSize: 25.0))
        ],
      ),
    );

    return  Stack(
      children: <Widget>[
        fondoMorado,
        Positioned( child: circulo, top: 90.0, left: 90.0 ),
        Positioned( child: circulo, top: -40.0, right: -30.0 ),
        Positioned( child: circulo, bottom: -50.0, right: -10.0 ),
        Positioned( child: circulo, bottom: 120.0, right: 20.0 ),
        logo
      ],
    );
  }
}