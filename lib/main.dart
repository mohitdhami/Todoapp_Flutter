import 'package:flutter/material.dart';
import 'initialRoute.dart';
 void main()=> runApp(MyApp());

 class MyApp extends StatelessWidget {
   const MyApp({Key key}) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       initialRoute:InitialRoute.id,
       routes: {
         InitialRoute.id : (context) => InitialRoute(),
       },
     
     );
   }
 }

