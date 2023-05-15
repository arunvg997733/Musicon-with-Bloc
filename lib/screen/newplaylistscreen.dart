import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/widgets/widget.dart';

class Newplaylistscreen extends StatelessWidget {
   Newplaylistscreen({super.key,required this.data});
  Playlistmodel data;

  @override
  Widget build(BuildContext context) {
    newplaylistnotifier.value = data.playlistarray;
    return Scaffold(
      appBar: AppBar(
        title: headtext(data.playlistname),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions:[
          IconButton(onPressed: () {
            allsongbottomsheet(context, data.playlistname);
          }, icon: Icon(Icons.add_circle_outline,color: Colors.white,))
        ],
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(valueListenable: newplaylistnotifier, builder:(BuildContext ctx, List<Songsmodel>playlistarray, Widget? child) {
            return data.playlistarray.isNotEmpty ? ListView.separated(
            itemBuilder: (context, index) {
              final songdata = playlistarray[index];
              return songbar4(songdata, context, index, data,);
            }, 
            separatorBuilder: (context, index) {
              return SizedBox(height: 15,);
            }, 
            itemCount:data.playlistarray.length ):Center(child: headtext('No Songs'));
          })
        ),
      )
    );
  }
}