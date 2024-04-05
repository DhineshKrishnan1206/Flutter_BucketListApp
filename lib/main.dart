import 'package:bucketlist/MainScreen.dart';
import 'package:bucketlist/addBucketList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      theme: ThemeData(fontFamily: "Poppins"),

      debugShowCheckedModeBanner: false,
      home: MainScreen(),);
  }
}
