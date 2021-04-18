import 'package:flutter/material.dart';
import 'package:stock/src/bloc/provider.dart';
import 'package:stock/src/models/producto_model.dart';
import 'package:stock/src/providers/productos_providers.dart';


    class HomePage extends StatelessWidget {
//   @override
//   _CounterState createState() => _CounterState();
// }

// class _CounterState extends State<Counter> {
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
      
  //   );
  // }

// class HomePage extends StatefulWidget {

//   // @override
//   // _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
  final productosProviders = new ProductosProviders();

  @override
  Widget build(BuildContext context) {

    final bloc =  Provider.of(context); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado (){

    return FutureBuilder(
      future: productosProviders.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if ( snapshot.hasData ){

          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i], productos, i)
          );

        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto, List<ProductoModel> prod, int position) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productosProviders.deleteProductById(producto.id);
      },
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text(producto.id),
        onTap: () => Navigator.pushNamed(context, 'producto',arguments: producto),
      ),
    );
  }

  _crearBoton(BuildContext context){

    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'producto')
    );

  }
}