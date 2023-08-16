import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/infrastructure/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Recentscreen extends StatelessWidget {
  const Recentscreen({super.key});

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
              return recentlistnotifier.value.isNotEmpty?ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = recentlist[index];
                  return songbar3(data, context, index,recentlistnotifier.value);
                }, 
                separatorBuilder: (context, index) {
                  return const SizedBox( height: 15,);
                }, 
                itemCount: recentlist.length):
                Center(child: headtext('No songs'));
        
            }),
        )
      )
    );
  }
}