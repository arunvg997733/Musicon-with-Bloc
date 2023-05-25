import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/screen/splashscreen.dart';

void main() {
  Hive.initFlutter();
  if(!Hive.isAdapterRegistered(SongsmodelAdapter().typeId)){
    Hive.registerAdapter(SongsmodelAdapter());
  }
  if(!Hive.isAdapterRegistered(PlaylistmodelAdapter().typeId)){
    Hive.registerAdapter(PlaylistmodelAdapter());
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

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