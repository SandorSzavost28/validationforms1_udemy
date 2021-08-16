import 'package:flutter/material.dart';
import 'package:validacionforms1_udemy/screens/screens.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validación Forms App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : ( _ ) => LoginScreen(),
        'home'  : ( _ ) => HomeScreen()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[600],
      ),
      
    );
  }
}