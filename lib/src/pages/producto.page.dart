import 'package:flutter/material.dart';
import 'package:stock/src/models/producto_model.dart';
import 'package:stock/src/providers/productos_providers.dart';
import 'package:stock/src/utils/utils.dart' as utils;


class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final productoProvider = new ProductosProviders();

  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.deepPurple,
       title: Text('Producto'),
       actions: [
         IconButton(
           icon: Icon(Icons.photo_size_select_actual),
            onPressed: (){}
        ),
        IconButton(
           icon: Icon(Icons.camera_alt),
            onPressed: (){}
        )
       ],
     ),
     body: SingleChildScrollView(
       padding: EdgeInsets.all(15.0),
       child: Form(
         key: formKey,
         child: Column(
           children: [
             _crearNombre(),
             _crearPrecio(),
             _crearDisponible(),
             _crearBoton(),
           ],
         )
        ),
     ),
   );
  }

  Widget _crearNombre(){

    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value)=> producto.titulo = value,
      validator: (value) {
        if (value.length <3) {
          return 'ingrese el nombre de un producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value)=> producto.valor = double.parse(value),
      validator: (value){

        if ( utils.isNumeric (value) ){
          return null;
        }else{
          return 'Solo se permite Numeros';
        }
        
      },
    );
  }

  Widget _crearDisponible(){
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value)=>setState((){
        producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton(){
   return ElevatedButton.icon(
     style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states)
      { return Colors.deepPurple;
      }),),
     label: Text('Guardar'),
     icon: Icon(Icons.save),
     autofocus: true,
     onPressed: _sudmit,
   );
  }  

  void _sudmit(){

    if (!formKey.currentState.validate()) return;


    formKey.currentState.save();

    print(producto.titulo);
    print(producto.valor);
    print(producto.disponible);

    productoProvider.crearProducto(producto);


  }
}
