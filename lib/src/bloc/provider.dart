import 'package:flutter/material.dart';
import 'package:patron_bloc/src/bloc/login_bloc.dart';
import 'package:patron_bloc/src/bloc/productos_bloc.dart';

class Provider extends InheritedWidget {

  static Provider _instancia;

  final _loginBloc      = new LoginBloc();
  final _productosBloc  = new ProductosBloc();

// esto sirve para que validar si la instancia ya esta creada y que no cree una nuva
  factory Provider({ Key key, Widget child }){

    if( _instancia == null ){
      _instancia = new Provider._insternal(key: key, child: child);
    }

    return _instancia;

  }

   Provider._insternal({ Key key, Widget child }) 
      : super(key: key, child: child);


  @override
  bool updateShouldNotify( InheritedWidget oldWidget ) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._loginBloc;
  }

  static ProductosBloc productosBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._productosBloc;
  }

 

}