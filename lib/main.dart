import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/screen/splashscreen.dart';

void main() {
  Hive.initFlutter();
  if(!Hive.isAdapterRegistered(SongsmodelAdapter().typeId)){
    Hive.registerAdapter(SongsmodelAdapter());
  }

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey
      ),
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
    );
  }
}