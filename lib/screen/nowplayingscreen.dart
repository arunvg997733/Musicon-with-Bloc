import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/player/playercontroller.dart';
import 'package:musicon/widgets/widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Nowplayingscreen extends StatelessWidget {
   Nowplayingscreen({super.key,required this.data});

  Songsmodel data;
 
  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(Playercontroller());
    return  Scaffold(
      appBar: AppBar(
        title: headtext('Now Playing'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      body: Container(
        decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: QueryArtworkWidget(id: data.id, type: ArtworkType.AUDIO,nullArtworkWidget:Image.asset('assets/musiconlogo.png') ,),
                  ),
                ),
              ),
            ),
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
                                  
                                }, icon: const Icon(Icons.repeat)),
                                IconButton(onPressed: () {
                                  
                                }, icon: const Icon(Icons.favorite))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              IconButton(onPressed: () {
                                  audioPlayer.seekBy(Duration(seconds: -10));
                                }, icon: const Icon(Icons.skip_previous_sharp,size: 40)),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 22,
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: IconButton(onPressed: () {
                                    playsong(data.uri);
                                    
                                    }, icon: const Icon(Icons.play_arrow)),
                                ),
                              ),
                              IconButton(onPressed: ()async {
                                  // audioPlayer.seekBy(Duration(seconds: 10));
                                 await audioPlayer.next();
                                }, icon: const Icon(Icons.skip_next_sharp,size: 40)),
                            
                            ],),
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
      )
    );
  }
} 