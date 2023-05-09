import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/player/playercontroller.dart';
import 'package:musicon/widgets/widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class Nowplayingscreen extends StatefulWidget {
   Nowplayingscreen({super.key,required this.data});

  Songsmodel data;

  @override
  State<Nowplayingscreen> createState() => _NowplayingscreenState();
}

class _NowplayingscreenState extends State<Nowplayingscreen> {

  
  
    //  int index = audioPlayer.current.value!.index;
      

 
  @override
  Widget build(BuildContext context) {
  bool isfavourate = favouritechecking(widget.data);
  bool isplaying = audioPlayer.isPlaying.value;
     
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

        




        
        return Container(
        decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
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
            TextScroll(playing.audio.audio.metas.title!,style: TextStyle(color: Colors.amber,fontSize: 25),mode: TextScrollMode.endless),
            Expanded(
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
                                  
                                }, icon: const Icon(Icons.playlist_add)),
                                IconButton(onPressed: () {
                                  
                                  
                                }, icon: const Icon(Icons.shuffle)),
                                IconButton(onPressed: () {
                                  audioPlayer.toggleShuffle();
                                }, icon: const Icon(Icons.repeat)),
                                IconButton(onPressed: () {
                                  setState(() {
                                    if(isfavourate==false){
                                      addtofavoritedatabase(widget.data, context);
                                    }else{
                                      deletefavouritelistontap(widget.data, context);
                                    }
                                    
                                  });
                                  
                                }, icon:isfavourate==true?const Icon(Icons.favorite):Icon(Icons.favorite_border))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              IconButton(onPressed: () {
                                  audioPlayer.previous();
                                  final data = audioPlayer.current;
                                }, icon: const Icon(Icons.skip_previous_sharp,size: 40)),
                              IconButton(onPressed: () {
                                  audioPlayer.seekBy(Duration(seconds: -10));
                                }, icon: const Icon(Icons.replay_10,size: 40)),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 22,
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: IconButton(onPressed: () {
                                     
                                    setState(() {
                                      audioPlayer.playOrPause();
                                    });
                                    
                                    }, icon:isplaying!=true? const Icon(Icons.play_arrow):const Icon(Icons.pause)),
                                ),
                              ),
                              IconButton(onPressed: () {
                                  audioPlayer.seekBy(Duration(seconds: 10));
                                }, icon: const Icon(Icons.forward_10,size: 40)),
                              IconButton(onPressed: ()async {
                                 audioPlayer.next();
                                }, icon: const Icon(Icons.skip_next_sharp,size: 40)),
                            
                            ],
                            ),
                            
                            Slider(value: 0.0, onChanged: (value) {
                             
                            },)
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