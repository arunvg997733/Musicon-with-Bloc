import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/player/playercontroller.dart';
import 'package:musicon/screen/newplaylistscreen.dart';
import 'package:musicon/screen/nowplayingscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget headtext(String text){
return Text(text,style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),);
}


class songlistbar extends StatefulWidget {
   songlistbar({super.key,required this.data,required this.context,required this.index,required this.songlist});

  Songsmodel data;
  BuildContext context;
  int index;
  List songlist;

  @override
  State<songlistbar> createState() => _songlistbarState();
}

class _songlistbarState extends State<songlistbar> {
  @override
  Widget build(BuildContext context) {
    bool isfavouritecheck = favouritechecking(widget.data);
    return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: const Color.fromARGB(204, 158, 158, 158),
      child:  ListTile(
        onTap: () {
          playsong(widget.index,widget.songlist);
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Nowplayingscreen(data:widget.data)));
        },
        leading: CircleAvatar(
        radius: 25,
        child: QueryArtworkWidget(id:widget.data.id, type: ArtworkType.AUDIO,nullArtworkWidget: Image.asset('assets/musiconlogo.png',height: 35,),)),
        title: Text(widget.data.name,overflow:TextOverflow.ellipsis,),
        subtitle: Text(widget.data.artist,overflow: TextOverflow.ellipsis,),
        trailing: Wrap(
          children: [
            IconButton(onPressed: () {
              playlistbottomsheet(context,widget.data);

            }, icon: const Icon(Icons.playlist_add)),
            IconButton(onPressed: () {
              setState(() {
                if(isfavouritecheck == false){
                  addtofavoritedatabase(widget.data,context);
                  
                }else{
                  deletefavouritelistontap(widget.data,widget.context);
                  
                }
                
              });
              
              
            }, icon:isfavouritecheck==true ? const Icon(Icons.favorite):Icon(Icons.favorite_border_outlined),)

          ],
        )
      
      ),
    ),
  );
  }
}

// Widget songbar( Songsmodel data,context,int index,List songlist){

//   // isfavouritecheck.value = favouritechecking(data);
//   bool isfavouritecheck = favouritechecking(data);

//   return ClipRRect(
//     borderRadius: BorderRadius.circular(50),
//     child: Container(
//       color: const Color.fromARGB(204, 158, 158, 158),
//       child:  ListTile(
//         onTap: () {
//           playsong(index,songlist);
//           Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Nowplayingscreen(data:data)));
//         },
//         leading: CircleAvatar(
//         radius: 25,
//         child: QueryArtworkWidget(id:data.id, type: ArtworkType.AUDIO,nullArtworkWidget: Image.asset('assets/musiconlogo.png',height: 35,),)),
//         title: Text(data.name,overflow:TextOverflow.ellipsis,),
//         subtitle: Text(data.artist,overflow: TextOverflow.ellipsis,),
//         trailing: Wrap(
//           children: [
//             IconButton(onPressed: () {

//             }, icon: const Icon(Icons.playlist_add)),
//             IconButton(onPressed: () {
//               addtofavoritedatabase(data,context);
              
//             }, icon:isfavouritecheck==true ? const Icon(Icons.favorite):Icon(Icons.favorite_border_outlined),)

//           ],
//         )
      
//       ),
//     ),
//   );
// }

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

Widget songbar2( Songsmodel data,context,int index,List newlist){
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: const Color.fromARGB(204, 158, 158, 158),
      child:  ListTile(
        onTap: () {
          playsong(index,newlist);
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Nowplayingscreen(data:data)));
        },
        leading: CircleAvatar(
        radius: 25,
        child: QueryArtworkWidget(id:data.id, type: ArtworkType.AUDIO,nullArtworkWidget: Image.asset('assets/musiconlogo.png',height: 35,),)),
        title: Text(data.name,overflow:TextOverflow.ellipsis,),
        subtitle: Text(data.artist,overflow: TextOverflow.ellipsis,),
        trailing: Wrap(
          children: [
            // IconButton(onPressed: () {
              
            // }, icon: const Icon(Icons.playlist_add)),
            IconButton(onPressed: () {

              showDialog(context: context, builder:(context) {
                return AlertDialog(
                  title: Text('Are you sure to delete'),
                  actions: [
                    
                    TextButton(onPressed: () {
                      deletefavouritelist(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleted'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),)
                          );
                      Navigator.of(context).pop();
                    }, child: Text('Yes')),
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text('No'))



                ],);
              },);
            }, icon: const Icon(Icons.delete),)

          ],
        )
      
      ),
    ),
  );
}


Widget songbar3( Songsmodel data,context,int index,List newlist){
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: const Color.fromARGB(204, 158, 158, 158),
      child:  ListTile(
        onTap: () {
          playsong(index,newlist);
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Nowplayingscreen(data:data)));
        },
        leading: CircleAvatar(
        radius: 25,
        child: QueryArtworkWidget(id:data.id, type: ArtworkType.AUDIO,nullArtworkWidget: Image.asset('assets/musiconlogo.png',height: 35,),)),
        title: Text(data.name,overflow:TextOverflow.ellipsis,),
        subtitle: Text(data.artist,overflow: TextOverflow.ellipsis,),
        trailing: Wrap(
          children: [
            // IconButton(onPressed: () {
            // }, icon: const Icon(Icons.playlist_add)),
            Text(data.count.toString())
          ],
        )
      
      ),
    ),
  );
}

Widget playlistbar(Playlistmodel data,context,Songsmodel songdata){
  return ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color: const Color.fromARGB(204, 158, 158, 158),
                child:  ListTile(
                  onTap: () {
                    songaddtoplaylistdatabase(data.playlistname, songdata,context);
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (ctx) => Newplaylistscreen(data: data,)));
                  },
                  leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/musiconlogo.png')
                  ),
                  title: Text(data.playlistname),
                  subtitle: data.playlistarray.length!=0 ? Text('${data.playlistarray.length.toString()} Songs'):Text('Empty'),
                  trailing: Wrap(
            children: const[
              
            ],
        )
                
      ),
    ),
  );
}

Widget songbar4( Songsmodel data,context,int index,Playlistmodel listdata){
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: const Color.fromARGB(204, 158, 158, 158),
      child:  ListTile(
        onTap: () {
          playsong(index,listdata.playlistarray);
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
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title:  Text('Do you want to delete'),
                  actions: [
                    TextButton(onPressed: () {
                      songsdeletefromplaylist(data, listdata.playlistname);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Song deleted from playlist'),duration: Duration(seconds: 1),));
                      Navigator.pop(context);
                    }, child: Text('Yes')),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('No'))

                ],);
              },);
              
            }, icon: const Icon(Icons.delete)),
            
          ],
        )
      
      ),
    ),
  );
}


Widget songbar5( Songsmodel data,context,int index,String listname){
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: const Color.fromARGB(204, 158, 158, 158),
      child:  ListTile(
        
        leading: CircleAvatar(
        radius: 25,
        child: QueryArtworkWidget(id:data.id, type: ArtworkType.AUDIO,nullArtworkWidget: Image.asset('assets/musiconlogo.png',height: 35,),)),
        title: Text(data.name,overflow:TextOverflow.ellipsis,),
        subtitle: Text(data.artist,overflow: TextOverflow.ellipsis,),
        trailing: Wrap(
          children: [
            IconButton(onPressed: () {
              songaddtoplaylistdatabase(listname, data, context);
            }, icon: Icon(Icons.add))
            
          ],
        )
      
      ),
    ),
  );
}



