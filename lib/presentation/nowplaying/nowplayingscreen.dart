import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicon/infrastructure/db_function.dart/db_function.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/player/playercontroller.dart';
import 'package:musicon/presentation/widgets/widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

 bool isshuffle = false;
 bool isloop = false;

class Nowplayingscreen extends StatefulWidget {
   Nowplayingscreen({super.key,required this.data});

  final Songsmodel data;

  @override
  State<Nowplayingscreen> createState() => _NowplayingscreenState();
}

class _NowplayingscreenState extends State<Nowplayingscreen> {

 

  

 
  @override
  Widget build(BuildContext context) {

  
     
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: headtext('Now Playing'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      body: audioPlayer.builderCurrent(builder: (context, playing) {
        int songid  = int.parse(playing.audio.audio.metas.id!);
        findsong(songid);
        Songsmodel songdata = findsongwithid(songid);
        bool isfavourate = favouritechecking(songdata);
        return Container(
        decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 15),
                child: Container(
                  
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: QueryArtworkWidget(id:int.parse(playing.audio.audio.metas.id!
                    ), type: ArtworkType.AUDIO,nullArtworkWidget:Image.asset('assets/musiconlogo.png') ,),
                  ),
                ),
              ),
            ),
            TextScroll(playing.audio.audio.metas.title!,style: const TextStyle(color: Colors.amber,fontSize: 25),mode: TextScrollMode.endless),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.grey,Color.fromRGBO(75, 75, 75, 1)],
                      begin: Alignment.topRight)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(onPressed: () {
                                  playlistbottomsheet(context, widget.data);
                                }, icon: const Icon(Icons.playlist_add)),
                                IconButton(onPressed: () {
                                  setState(() {
                                    if(isshuffle == false){
                                     audioPlayer.toggleShuffle();
                                     isshuffle = true;
                                  }else{
                                    audioPlayer.toggleShuffle();
                                     isshuffle = false;
                                  }
                                  });
                                  
                                }, icon:isshuffle==false ? const Icon(Icons.shuffle):const Icon(Icons.shuffle,color: Colors.amber,)),
                                IconButton(onPressed: () {
                                  setState(() {
                                    if(isloop == false){
                                      audioPlayer.setLoopMode(LoopMode.single);
                                      isloop = true;
                                    }else{
                                      audioPlayer.setLoopMode(LoopMode.playlist);
                                      isloop = false;
                                    }
                                  });
                                  
                                }, icon:isloop ==false ? const Icon(Icons.repeat):const Icon(Icons.repeat,color: Colors.amber,)),
                                IconButton(onPressed: () {
                                  setState(() {
                                    if(isfavourate==false){
                                      addtofavoritedatabase(songdata);
                                    }else{
                                      deletefavouritelistontap(songdata);
                                    }
                                    
                                  });
                                  
                                }, icon:isfavourate==true?const Icon(Icons.favorite,color: Color.fromARGB(255, 185, 25, 14)):const Icon(Icons.favorite_border))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              IconButton(onPressed: () {
                                 audioPlayer.previous();
                                }, icon: const Icon(Icons.skip_previous_sharp,size: 40)),
                              IconButton(onPressed: () {
                                  audioPlayer.seekBy(const Duration(seconds: -10));
                                }, icon: const Icon(Icons.replay_10,size: 40)),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 22,
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: PlayerBuilder.isPlaying(
                                      player: audioPlayer, 
                                      builder: (context, isPlaying) {
                                      return IconButton(onPressed: () {
                                        if(isPlaying==false){
                                        audioPlayer.play();
                                      }else{
                                        audioPlayer.pause();
                                      }
                                      }, icon:isPlaying==true? const Icon(Icons.pause):const Icon(Icons.play_arrow) );
                                      },)
                                  
                                ),
                              ),
                              IconButton(onPressed: () {
                                  audioPlayer.seekBy(const Duration(seconds: 10));
                                }, icon: const Icon(Icons.forward_10,size: 40)),
                              IconButton(onPressed: ()async {
                                audioPlayer.next();
                                }, icon: const Icon(Icons.skip_next_sharp,size: 40)),
                            
                            ],
                            ),
                            // Musicslider()
                            Musicsliders()
                            // musicslider()
                           

                          ],
                        ),
                      ),
        
                ),
              ),
            )
          ],
        ),
            );
      },)
    );
  }
} 