import 'package:flutter/material.dart';
import 'package:patron_bloc/src/bloc/productos_bloc.dart';
import 'package:patron_bloc/src/models/product_model.dart';
import 'package:patron_bloc/src/utils/utils.dart' as Utils;
import 'package:image_picker/image_picker.dart';
import 'package:patron_bloc/src/bloc/provider.dart';

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductosBloc productosBloc;

  ProductoModel productoModel = new ProductoModel();
  bool _guardando = false;
  var image;

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      productoModel = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Pagina de productos'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: seleccionarFotosGaleria),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: tomarFotoCamara)
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                Divider(),
                _crearBoton()
              ],
            )),
      )),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: productoModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'producto'),
      onSaved: (value) => productoModel.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'ingrese un producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: productoModel.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'precio'),
      onSaved: (value) => productoModel.valor = double.parse(value),
      validator: (value) {
        if (Utils.isNumeric(value)) {
          return null;
        } else {
          return 'esto no es un numero';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: productoModel.disponible,
      title: Text("Disponible"),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        setState(() {
          productoModel.disponible = value;
        });
      },
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (image != null) {
      productoModel.fotoUrl = await productosBloc.subirFoto(image);
    }

    if (productoModel.id == null) {
      productosBloc.agregarProducto(productoModel);
    } else {
      productosBloc.editarProducto(productoModel);
    }

    setState(() {
      _guardando = false;
    });
    mostrarSnackbar("Registro guardado!");

    Navigator.pop(context);
  }

  void mostrarSnackbar(mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _crearFoto() {
    if (productoModel.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(productoModel.fotoUrl),
        height: 200.0,
        fit: BoxFit.cover,
        fadeInDuration: Duration(milliseconds: 150),
        placeholder: AssetImage("assets/jar-loading.gif"),
      );
    } else {
      return Image(
          image: AssetImage(image?.path ?? 'assets/no-image.png'),
          height: 300.0,
          fit: BoxFit.cover);
    }
  }

  void tomarFotoCamara() {
    getFoto(ImageSource.camera);
  }

  void seleccionarFotosGaleria() {
    getFoto(ImageSource.gallery);
  }

  Future getFoto(ImageSource source) async {
    image = await ImagePicker.pickImage(source: source);

    if (image != null) {}

    setState(() {});
  }
}