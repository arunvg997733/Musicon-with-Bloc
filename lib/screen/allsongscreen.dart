import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/widgets/widget.dart';

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
              child: allsongnotifierlist!=null ? ValueListenableBuilder(
                valueListenable: allsongnotifierlist,
                builder: (BuildContext ctx, List<Songsmodel> newallsonglist, Widget? child) {
                  return ListView.separated(
                  itemBuilder: (context, index) {
                    final data = newallsonglist[index];
                    return songlistbar(data: data, context: context, index: index, songlist: allsongnotifierlist.value);
                    // songbar(data, context,index,allsongnotifierlist.value);
                  }, 
                  separatorBuilder: (context, index) => SizedBox(height: 15,), 
                  itemCount:newallsonglist.length );
                },
                
              ):Center(child: headtext('No Songs')),
            )
        

      ),

      
    );
  }

  // addsongtofavourite(String name,String artist,String uri, String id){

  //    final newsong = Songsmodel(name: name, artist: artist, uri: uri, id: id);
     
  //    songnotifierlist.value.add(newsong);
  //    songnotifierlist.notifyListeners();



  // }

  // addsong(SongModel data){

  //   final name = data.displayNameWOExt;
  //   final artist = data.artist;
  //   final uri = data.uri;
  //   final id = data.id;
    

  //   final newsongs = Songsmodel(name: name, artist: artist!, uri: uri!, id:id.toString() );

  // songnotifierlist.value.add(newsongs);


  // }

}