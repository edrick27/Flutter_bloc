import 'package:flutter/material.dart';
import 'package:patron_bloc/src/bloc/provider.dart';

import 'package:patron_bloc/src/route/route.dart';
 
void main() => runApp(MyApp());
 
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