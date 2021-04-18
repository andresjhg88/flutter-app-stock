import 'package:flutter/material.dart';
import 'package:stock/src/bloc/provider.dart';
import 'package:stock/src/pages/home_page.dart';
import 'package:stock/src/pages/login_page.dart';
import 'package:stock/src/pages/producto.page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock',
      initialRoute: 'home',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home' : (BuildContext context) => HomePage(),
        'producto' : (BuildContext context) => ProductoPage(),
      },
      )
    );
    
    
    
    
  }
}