import 'dart:io';

import 'package:patron_bloc/src/providers/productos_provider.dart';
import 'package:rxdart/subjects.dart';


import 'package:patron_bloc/src/models/product_model.dart';



class ProductosBloc {

  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _productosProvider = new ProductoProviders();


  Stream<List<ProductoModel>> get productosStream => _productosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;


  void cargarProductos() async {

    final productos = await _productosProvider.obtenerProductos();
    _productosController.sink.add(productos);

  }

  void agregarProducto(ProductoModel producto) async {

    _cargandoController.sink.add(true);
    final productos = await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto(File foto) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _productosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);
    
    return fotoUrl;

  }

  
  void editarProducto(ProductoModel producto) async {

    _cargandoController.sink.add(true);
    final productos = await _productosProvider.actualizarProducto(producto);
    _cargandoController.sink.add(false);

  }
  
  void eliminarProducto(String id) async {

    final productos = await _productosProvider.borrarProducto(id);

  }


  dispose(){
    _productosController?.close();
    _cargandoController?.close();
  }

}