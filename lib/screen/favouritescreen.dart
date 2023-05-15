import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/widgets/widget.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: headtext('Favourites'),
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
        decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(
            valueListenable: favoritelistnotifier, builder:(BuildContext ctx, List<Songsmodel> favouritelist, Widget? child){
              return favouritelist.isNotEmpty?ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = favouritelist[index];
                  return songbar2(data,context,index,favoritelistnotifier.value);
                  
                }, 
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 15,);
                }, 
                itemCount: favouritelist.length):
                Center(child: headtext('No Songs'));
        
            } ),
        )
      )
    );
  }



}