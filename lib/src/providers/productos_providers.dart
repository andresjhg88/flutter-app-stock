
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock/src/models/producto_model.dart';

class ProductosProviders{

  final String _url = 'https://stock-2765e-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    //final url = Uri.https(_url, 'productos.json');
    final url1 = '$_url/productos.json';
    var resp =
        await http.post(Uri.parse(url1), body: productoModelToJson(producto));
 
    final decodedData = json.decode(resp.body);
 
    print(decodedData);
 
    return true;
  }

  Future <List<ProductoModel>> cargarProductos() async {

    final url  = '$_url/productos.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = [];

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {

      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id    = id;

      productos.add( prodTemp );

    });

    //print(productos[0].id);

    return productos;

  }

  Future<int> deleteProductById(String id) async {
    final url = '$_url/productos/$id.json';
 
    final response = await http.delete(Uri.parse(url));
 
    print(json.decode(response.body));
 
    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    //final url = Uri.https(_url, 'productos.json');
    final url1 = '$_url/productos/${producto.id}.json';
    var resp =
        await http.put(Uri.parse(url1), body: productoModelToJson(producto));
 
    final decodedData = json.decode(resp.body);
 
    print(decodedData);
 
    return true;

  }

}

