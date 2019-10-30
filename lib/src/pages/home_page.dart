import 'package:flutter/material.dart';
import 'package:patron_bloc/src/bloc/productos_bloc.dart';

import 'package:patron_bloc/src/bloc/provider.dart';
import 'package:patron_bloc/src/models/product_model.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final productosbloc = Provider.productosBloc(context);
    productosbloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage")
      ),
      body: _crearListado(productosbloc),
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

  Widget _crearListado(ProductosBloc productosbloc){

    return StreamBuilder(
      stream: productosbloc.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
      
       if(snapshot.hasData){

          final listaProductos = snapshot.data;

          return ListView.builder(
            itemCount: listaProductos.length,
            itemBuilder: (BuildContext context, int i) => _crearItems(context, listaProductos[i], productosbloc)
          );

        } else {
        
          return Center(
            child: CircularProgressIndicator()
          );

        }
      }
    );
  }

  Widget _crearItems(BuildContext context, ProductoModel producto, ProductosBloc productosbloc){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direccion ) => productosbloc.eliminarProducto(producto.id),
      child: Card(
        child: Column(
          children: <Widget>[
            (producto.fotoUrl == null) 
              ? Image( image: AssetImage("assets/no-image.png"), height: 200.0, )
              : FadeInImage(
                  image: NetworkImage(
                    producto.fotoUrl
                  ),
                  fit: BoxFit.cover,
                  placeholder: AssetImage("assets/jar-loading.gif"),
                  height: 200.0,
                  width: double.infinity,
                ),
              ListTile(
                title: Text(producto.titulo),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, "producto", arguments: producto)
              )
          ],
        )
      )
    );
  }
}