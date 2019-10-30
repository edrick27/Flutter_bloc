import 'package:flutter/material.dart';

import 'package:patron_bloc/src/pages/home_page.dart';
import 'package:patron_bloc/src/pages/login_page.dart';
import 'package:patron_bloc/src/pages/producto_page.dart';
import 'package:patron_bloc/src/pages/registro_page.dart';

Map<String, WidgetBuilder> getRoutes(){

  return <String, WidgetBuilder>{
        '/' : (BuildContext context) => LoginPage(),
        'home'  : (BuildContext context) => HomePage(),
        'producto'  : (BuildContext context) => ProductosPage(),
        'registro'  : (BuildContext context) => RegistroPage(),
  };
}