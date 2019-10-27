import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:patron_bloc/src/models/product_model.dart';

class ProductoProviders {

  final String _url = 'https://flutter-varios-312d0.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async{

    final url = '$_url/productos.json';

    final response = await http.post( url, body: productoModelToJson(producto) );
  
    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<bool> actualizarProducto(ProductoModel producto) async{

    final url = '$_url/productos/${ producto.id }.json';

    final response = await http.put( url, body: productoModelToJson(producto) );
  
    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<List<ProductoModel>> obtenerProductos() async{

    final url = "$_url/productos.json";
    
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    if( decodeData == null ) return [];

    final List<ProductoModel> productos = new List();

    decodeData.forEach((id, producto) {

      final nuevoProducto = new ProductoModel.fromJson(producto);
      nuevoProducto.id = id;

      productos.add(nuevoProducto);

    });

    return productos;
  }

  Future<int> borrarProducto(String id) async{

    final url = "$_url/productos/$id.json";

    final resp = await http.delete(url);

    print(resp.body);

    return 1; 
  }


}