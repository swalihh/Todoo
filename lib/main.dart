import 'package:flutter/material.dart';
import 'package:new_provider/provider/studentmodal.dart';
import 'package:new_provider/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider())
      ],
      child:  MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home:const Home(),
      ),
    );
  }
}
