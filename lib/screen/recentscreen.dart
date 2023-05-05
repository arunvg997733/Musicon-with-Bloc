import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/widgets/widget.dart';

class recentscreen extends StatelessWidget {
  const recentscreen({super.key});

  @override
  Widget build(BuildContext context) {
    recentdatabasetolist();
    return Scaffold(
      appBar: AppBar(
        title: headtext('Recently Played'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),
        
      ),
      body:Container(
        decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ValueListenableBuilder(
            valueListenable: recentlistnotifier, 
            builder: (BuildContext ctx, List<Songsmodel> recentlist, Widget? child){
              return !recentlistnotifier.value.isEmpty?ListView.separated(
                itemBuilder: (context, index) {
                  final data = recentlist[index];
                  return songbar2(data, context, index,recentlistnotifier.value);
                }, 
                separatorBuilder: (context, index) {
                  return SizedBox( height: 15,);
                }, 
                itemCount: recentlist.length):
                Center(child: headtext('No songs'));
        
            }),
        )
      )
    );
  }
}