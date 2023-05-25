import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/player/playercontroller.dart';
import 'package:musicon/screen/nowplayingscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

Widget headtext(String text){
return Text(text,style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),);
}


class Songlistbar extends StatefulWidget {
   Songlistbar({super.key,required this.data,required this.context,required this.index,required this.songlist});

  Songsmodel data;
  BuildContext context;
  int index;
  List songlist;

  @override
  State<Songlistbar> createState() => SonglistbarState();
}

class SonglistbarState extends State<Songlistbar> {
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
              
              
            }, icon:isfavouritecheck==true ? const Icon(Icons.favorite,color: Color.fromARGB(255, 185, 25, 14),):const Icon(Icons.favorite_border_outlined,),)

          ],
        )
      
      ),
    ),
  );
  }
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

Widget settingstext(String text,IconData icon,context,int index){
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
                  title: const Text('Are you sure to delete'),
                  actions: [
                    
                    TextButton(onPressed: () {
                      deletefavouritelist(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Deleted'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),)
                          );
                      Navigator.of(context).pop();
                    }, child: const Text('Yes')),
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: const Text('No'))



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
          children: const [
            // IconButton(onPressed: () {
            // }, icon: const Icon(Icons.playlist_add)),
            // Text(data.count.toString())
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
                  subtitle: data.playlistarray.length!=0 ? Text('${data.playlistarray.length.toString()} Songs'):const Text('Empty'),
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
                  title:  const Text('Do you want to delete'),
                  actions: [
                    TextButton(onPressed: () {
                      songsdeletefromplaylist(data, listdata.playlistname);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Song deleted from playlist'),duration: Duration(seconds: 1),));
                      Navigator.pop(context);
                    }, child: const Text('Yes')),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text('No'))

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
            }, icon: const Icon(Icons.add))
            
          ],
        )
      
      ),
    ),
  );
}

class Minimusicplayer extends StatelessWidget {
  const Minimusicplayer({super.key});

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(builder: (context, playing) {
      int songid  = int.parse(playing.audio.audio.metas.id!);
      findsong(songid);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          final data = findsongwithid(int.parse(playing.audio.audio.metas.id.toString()));
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Nowplayingscreen(data:data)));
        },
        child: Card(
          color: const Color.fromARGB(255, 220, 121, 0),
          child: Container(
            height: 80,
            
            child: Row(children: [
              Expanded(
                
                child: CircleAvatar(
                  radius: 25,
                  child: QueryArtworkWidget(id: int.parse(playing.audio.audio.metas.id.toString()), type: ArtworkType.AUDIO,nullArtworkWidget: Image.asset('assets/musiconlogo.png',height: 35
                  ,),),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextScroll(playing.audio.audio.metas.title.toString(),),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: () {
                          audioPlayer.previous();
                        }, icon: const Icon(Icons.skip_previous)),
                        PlayerBuilder.isPlaying(player: audioPlayer, builder: (context, isPlaying) {
                          return IconButton(onPressed: () {
                         
                            if(isPlaying == false){
                            audioPlayer.play();
                          }else{
                            audioPlayer.pause();
                          }
                  
                        }, icon: isPlaying ==true ? const Icon(Icons.pause):const Icon(Icons.play_arrow));
                        },),
                        IconButton(onPressed: () {
                          audioPlayer.next();
                        }, icon: const Icon(Icons.skip_next)),
                        IconButton(onPressed: () {
                          audioPlayer.stop();
                        }, icon: const Icon(Icons.stop))
                      ],
                    )
              
                  ],
                ),
              )
            ],),
          ),
        ),
      ),
    );
  },);
  }
}

class Musicslider extends StatefulWidget {
  const Musicslider({super.key});

  @override
  State<Musicslider> createState() => _MusicsliderState();
}

class _MusicsliderState extends State<Musicslider> {
  double slidervalue =0;
  double duration =0;
  String totalmm = '';
  String totalss = '';
  String currentmm = '';
  String currentss = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.currentPosition.listen((event) { 
      final currentduration = event;
      currentmm = (currentduration.inMinutes %60).toString().padLeft(2,'0');
      currentss = (currentduration.inSeconds %60).toString().padLeft(2,'0');

      setState(() {
        slidervalue = event.inSeconds.toDouble();
      });
    });

  }
  @override
  Widget build(BuildContext context) {

    
    audioPlayer.current.listen((event) {
      final totalduration = event!.audio.duration;
      totalmm = (totalduration.inMinutes %60).toString().padLeft(2,'0');
      totalss = (totalduration.inSeconds %60).toString().padLeft(2,'0');
      duration = event.audio.duration.inSeconds.toDouble();

    });
    return Column(
      children: [
        Slider(value: slidervalue, min: 0.0,max: duration, onChanged: (value) {
          setState(() {
            slidervalue = value;
            audioPlayer.seek(Duration(seconds: slidervalue.toInt()));
          });
        },),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( '$currentmm:$currentss'),
              Text( '$totalmm:$totalss')

            // PlayerBuilder.currentPosition(player: audioPlayer, builder: (context, position) {
            //   final mm = (position.inMinutes %60).toString().padLeft(2,'0');
            //   final ss = (position.inSeconds %60).toString().padLeft(2,'0');
            //   return Text('${mm}:${ss}');
            // },),
            // PlayerBuilder.current(player: audioPlayer, builder: (context, playing) {
            //   final totalduration = playing.audio.duration;
            //   final mm = (totalduration.inMinutes %60).toString().padLeft(2,'0');
            //   final ss = (totalduration.inSeconds %60).toString().padLeft(2,'0');
            //   return Text('${mm}:${ss}');
            // },)
          ],),
        )
      ],
    );
  }
}

class Musicsliders extends StatefulWidget {
   Musicsliders({super.key});

  @override
  State<Musicsliders> createState() => _MusicslidersState();
}

class _MusicslidersState extends State<Musicsliders> {
  double slidervalue =0;

  double duration =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     audioPlayer.current.listen((event) {
      final totalduration = event!.audio.duration;
      duration = event.audio.duration.inSeconds.toDouble();

    });
  }

  @override
  Widget build(BuildContext context) {
    
    return PlayerBuilder.currentPosition(player: audioPlayer, builder: (context, position) {

    slidervalue = position.inSeconds.toDouble();

    return Column(
      children: [
        Slider(value: slidervalue, min: 0.0,max: duration, onChanged: (value) {
          
            slidervalue = value;
            audioPlayer.seek(Duration(seconds: slidervalue.toInt()));
         
        },),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              PlayerBuilder.currentPosition(player: audioPlayer, builder: (context, position) {
              final mm = (position.inMinutes %60).toString().padLeft(2,'0');
              final ss = (position.inSeconds %60).toString().padLeft(2,'0');
              return Text('$mm:$ss');
            },),
            PlayerBuilder.current(player: audioPlayer, builder: (context, playing) {
              final totalduration = playing.audio.duration;
              final mm = (totalduration.inMinutes %60).toString().padLeft(2,'0');
              final ss = (totalduration.inSeconds %60).toString().padLeft(2,'0');
              return Text('$mm:$ss');
            },)
              

           
          ],),
        )
      ],
    );
  },);
  }
}

Widget musicslider(){

  double slidervalue =0;
  double duration =0;

  audioPlayer.current.listen((event) {
      duration = event!.audio.duration.inSeconds.toDouble();
    });
    

  return PlayerBuilder.currentPosition(player: audioPlayer, builder: (context, position) {

    slidervalue = position.inSeconds.toDouble();

    return Column(
      children: [

        Slider(value: slidervalue, min: 0.0,max: duration, onChanged: (value) {
          
            slidervalue = value;
            audioPlayer.seek(Duration(seconds: slidervalue.toInt()));
         
        },),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal:20.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       PlayerBuilder.currentPosition(player: audioPlayer, builder: (context, position) {
        //       final mm = (position.inMinutes %60).toString().padLeft(2,'0');
        //       final ss = (position.inSeconds %60).toString().padLeft(2,'0');
        //       return Text('$mm:$ss');
        //     },),
        //     PlayerBuilder.current(player: audioPlayer, builder: (context, playing) {
        //       final totalduration = playing.audio.duration;
        //       final mm = (totalduration.inMinutes %60).toString().padLeft(2,'0');
        //       final ss = (totalduration.inSeconds %60).toString().padLeft(2,'0');
        //       return Text('$mm:$ss');
        //     },)
             
           
        //   ],),
        // )
      ],
    );
  },);
}










