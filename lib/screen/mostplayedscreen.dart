import 'package:flutter/material.dart';
import 'package:musicon/widgets/widget.dart';

class Mostplayedscreen extends StatelessWidget {
  const Mostplayedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: headtext('Most Played'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),
        actions: [
          IconButton(onPressed: () {
            
          }, icon: const Icon(Icons.search,color: Colors.white,))
        ],
      ),
      body:Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
        children: const [
          

        ],
      ))
    );
  }
}