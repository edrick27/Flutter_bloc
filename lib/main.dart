import 'package:flutter/material.dart';

import 'package:patron_bloc/src/bloc/provider.dart';
import 'package:patron_bloc/src/preferencias/preferencias_usuario.dart';
import 'package:patron_bloc/src/route/route.dart';

 
void main() async{
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Provider( 
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: '/',
        routes: getRoutes(),
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        )
      ),
     );
  }
}