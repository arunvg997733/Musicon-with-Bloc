import 'package:flutter/material.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/screen/nowplayingscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget headtext(String text){
return Text(text,style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),);
}

Widget songbar( Songsmodel data,context){
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: const Color.fromARGB(204, 158, 158, 158),
      child:  ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Nowplayingscreen(data:data)));
        },
        leading: CircleAvatar(
        radius: 25,
        child: QueryArtworkWidget(id:data.id, type: ArtworkType.AUDIO,nullArtworkWidget: Image.asset('assets/musiconlogo.png',height: 35,),)),
        title: Text(data.name,overflow:TextOverflow.ellipsis,),
        subtitle: Text(data.artist,overflow: TextOverflow.ellipsis,),
        trailing: Wrap(
          children: [
            IconButton(onPressed: () {
              
            }, icon: const Icon(Icons.playlist_add)),
            IconButton(onPressed: () {
              
            }, icon: const Icon(Icons.favorite_border),)

          ],
        )
      
      ),
    ),
  );
}

Widget topbar(String text){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.settings,color: Colors.white),
        headtext(text),
        const Icon(Icons.search,color: Colors.white,),
      ],
    ),
  );
}

Widget playbox(String text,int curretidx,int value){
  return Container(
    color:curretidx==value?Colors.grey: const Color.fromARGB(255, 63, 63, 63),
    child:Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/musiconlogo.png', height:curretidx==value? 110:80,),
          Text(text,style: TextStyle(
            color: curretidx==value?Colors.amber:Colors.black,
            fontWeight: curretidx==value?FontWeight.w900:null
            ),)
        ],
      ),
    )
  );
}

Widget settingstext(String text,IconData icon){
  return Row(
    children: [
      const SizedBox(width: 5,),
      Icon(icon,color: Colors.white,size:35,),
      const SizedBox(width: 15,),
      Text(text,style: const TextStyle(color: Colors.white,fontSize: 20),),
    ],
  );

}
