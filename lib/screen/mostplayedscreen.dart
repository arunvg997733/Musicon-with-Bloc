import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/widgets/widget.dart';

class Mostplayedscreen extends StatelessWidget {
  const Mostplayedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    mostplayeddatabasetolist();
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
        decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(
            valueListenable: mostplayedlistnotifier, 
            builder:(BuildContext ctx, List<Songsmodel> newlist, Widget?child){
              return newlist.isNotEmpty? ListView.separated(
                itemBuilder: (context, index) {
                  final data = newlist[index];
                  return songbar3(data, context, index,mostplayedlistnotifier.value);
                }, 
                separatorBuilder: (context, index) {
                  return SizedBox(height: 15,);
                }, 
                itemCount: newlist.length):Center(child: headtext('No Songs'));
        
            } ),
        )
      )
    );
  }
}