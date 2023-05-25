import 'dart:async';
import 'package:flutter/material.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/player/playercontroller.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () { 
      checkpermission();
      checkname(context);
    });
   
  }
  @override
  Widget build(BuildContext context) {
    
    
    return  Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset('assets/musiconlogo.png',scale: 4,),
        ),
      ),
    );
  }
}