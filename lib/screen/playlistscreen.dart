import 'package:flutter/material.dart';

class Playlistscreen extends StatelessWidget {
  const Playlistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image:AssetImage('assets/Background.png'),
            fit: BoxFit.cover,
            )
          ),
          width: double.infinity,
         
          child: Column(children: const [
      
          ],),
        
        ),
      ),
    );
  }
}