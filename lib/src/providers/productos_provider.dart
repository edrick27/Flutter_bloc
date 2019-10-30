import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:patron_bloc/src/models/product_model.dart';
import 'package:patron_bloc/src/preferencias/preferencias_usuario.dart';

class ProductoProviders {

  final String _url = 'https://flutter-varios-312d0.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async{

    final url = '$_url/productos.json?auth=${_prefs.token}';

    final response = await http.post( url, body: productoModelToJson(producto) );
  
    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<bool> actualizarProducto(ProductoModel producto) async{

    final url = '$_url/productos/${ producto.id }.json?auth=${_prefs.token}';

    final response = await http.put( url, body: productoModelToJson(producto) );
  
    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<List<ProductoModel>> obtenerProductos() async{

    final url = "$_url/productos.json?auth=${_prefs.token}";
    
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    if( decodeData == null ) return [];

    if( decodeData['error'] != null ) return [];

    final List<ProductoModel> productos = new List();

    decodeData.forEach((id, producto) {

      final nuevoProducto = new ProductoModel.fromJson(producto);
      nuevoProducto.id = id;

      productos.add(nuevoProducto);

    });

    return productos;
  }

  Future<int> borrarProducto(String id) async{

    final url = "$_url/productos/$id.json?auth=${_prefs.token}";

    final resp = await http.delete(url);

    print(resp.body);

    return 1; 
  }

  Future<String> subirImagen(File image) async {
//wacbmqzp

    final url = Uri.parse("https://api.cloudinary.com/v1_1/edrick27/image/upload?upload_preset=wacbmqzp");
    final mimeType = mime(image.path).split("/");

    final uploadRequest = http.MultipartRequest(
      'POST', 
      url
    );
  
    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType[0],mimeType[1])
    );

    uploadRequest.files.add(file);

    final streamResponse = await uploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if( response.statusCode != 200 && response.statusCode != 201 ){
      print("Algo salio mal");
      print(response.body);
      return null;
    }

    final responseData = json.decode(response.body);
  
      print("responseData");
      print(responseData);


    return responseData['secure_url'];

  }


}