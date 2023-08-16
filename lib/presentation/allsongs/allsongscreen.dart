import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/infrastructure/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Allsongscreen extends StatelessWidget {
  const Allsongscreen({super.key});

  @override
  Widget build(BuildContext context) {
    favouritedatabasetolist();
    return  Scaffold(

      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)),
            child:Padding(
              padding: const EdgeInsets.all(15.0),
              child: allsongnotifierlist.value.isNotEmpty? ValueListenableBuilder(
                valueListenable: allsongnotifierlist,
                builder: (BuildContext ctx, List<Songsmodel> newallsonglist, Widget? child) {
                  return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (contex, index) {
                    final data = newallsonglist[index];
                    return Songlistbar(data: data, context: context, index: index, songlist: allsongnotifierlist.value);
                  }, 
                  separatorBuilder: (context, index) => const SizedBox(height: 15,), 
                  itemCount:newallsonglist.length );
                },
                
              ):Center(child: headtext('No Songs')),
            )
        

      ),

      
    );
  }



}