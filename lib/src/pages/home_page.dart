import 'package:flutter/material.dart';
import 'package:patron_bloc/src/models/product_model.dart';
import 'package:patron_bloc/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {

  final productoProvider = new ProductoProviders();


  @override
  Widget build(BuildContext context) {

    // final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage")
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      backgroundColor: Colors.deepPurple,
    );
  }

  Widget _crearListado(){

    return FutureBuilder(
      future: productoProvider.obtenerProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
      
        if(snapshot.hasData){

          final listaProductos = snapshot.data;

          return ListView.builder(
            itemCount: listaProductos.length,
            itemBuilder: (BuildContext context, int i) => _crearItems(context, listaProductos[i])
          );

        } else {
        
          return Center(
            child: CircularProgressIndicator()
          );

        }
      },
    );

  }

  Widget _crearItems(BuildContext context, ProductoModel producto){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direccion ){
        productoProvider.borrarProducto(producto.id);
      },
      child: ListTile(
        title: Text(producto.titulo),
        subtitle: Text(producto.id),
        onTap: () => Navigator.pushNamed(context, "producto", arguments: producto)
      )
    );

  }
}