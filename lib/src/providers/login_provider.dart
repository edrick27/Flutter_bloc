import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:patron_bloc/src/preferencias/preferencias_usuario.dart';

class LoginProvider {
  
  final String _firebaseToken = 'AIzaSyC7w0bBZPsDUcfHwaHlKLyhSovhDsW1Ga0';
  final _prefs = new PreferenciasUsuario();

  
  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async{

    final String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken';

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true    
    };

    final resp = await http.post(url, body: json.encode(authData)); 

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if( decodeResp.containsKey('idToken')){

      _prefs.token = decodeResp['idToken'];
      
      return { 'ok': true, 'token': decodeResp['idToken'] };
    } else {
      return { 'ok': false, 'message': decodeResp['error']['message'] };
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async{

    final String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken';

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true    
    };

    final resp = await http.post(url, body: json.encode(authData)); 

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if( decodeResp.containsKey('idToken')){
      // salvar el token
      _prefs.token = decodeResp['idToken'];

      return { 'ok': true, 'token': decodeResp['idToken'] };
    } else {

      return { 'ok': false, 'message': decodeResp['error']['message'] };
    
    }
  }

}