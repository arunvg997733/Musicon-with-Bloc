import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicon/application/favourite/favourite_bloc.dart';
import 'package:musicon/application/navigationbar/navigationbar_bloc.dart';
import 'package:musicon/application/newplaylist/newplaylist_bloc.dart';
import 'package:musicon/application/playlist/playlist_bloc.dart';
import 'package:musicon/application/searchscreen/searchscreen_bloc.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/presentation/splash/splashscreen.dart';

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
    return  MultiBlocProvider(
        providers: [
            BlocProvider(
          create: (context) => NavigationbarBloc(),
    
        ),
            BlocProvider(
                create: (context) => SearchscreenBloc(),
            ),

            BlocProvider(
              create: (context) => FavouriteBloc(),
            ),

            BlocProvider(
              create: (context) => PlaylistBloc(),
            ),

            BlocProvider(
              create: (context) => NewplaylistBloc(),
            )

            

        ],
              child: MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.grey
              ),
              debugShowCheckedModeBanner: false,
              home: const Splashscreen(),
            ),
    );
  }
}