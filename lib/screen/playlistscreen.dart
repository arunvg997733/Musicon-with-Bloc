import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/screen/newplaylistscreen.dart';
import 'package:musicon/widgets/widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlistscreen extends StatelessWidget {
  const Playlistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    playlistdatabasetolist();
    return  Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image:AssetImage('assets/Background.png'),
            fit: BoxFit.cover,
            )
          ),
          width: double.infinity,
         
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ValueListenableBuilder(valueListenable: playlistnotifier, builder:(BuildContext ctx, List<Playlistmodel> newlist, Widget? child){
              return playlistnotifier.value.isNotEmpty ? ListView.separated(
                itemBuilder: (context, index) {
                  final data = newlist[index];
                  return ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color: const Color.fromARGB(204, 158, 158, 158),
                child:  ListTile(
                  onTap: () {
                    
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Newplaylistscreen(data: data,)));
                  },
                  leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/musiconlogo.png')
                  ),
                  title: Text(data.playlistname),
                  subtitle: data.playlistarray.length!=0 ? Text('${data.playlistarray.length.toString()} Songs'):Text('Empty'),
                  trailing: Wrap(
                  children: [
                    IconButton(onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: Text('Do you want to delete'),
                          actions: [
                            TextButton(onPressed: () {
                              deleteplaylistdatabase(data);
                              Navigator.pop(context);
                            }, child: Text('Yes')),
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text('No'))

                          ],
                        );
                      },);
                      
                    }, icon: Icon(Icons.delete))
              
                  ],
        )
                
      ),
    ),
  );
                  
                  
            //       ClipRRect(
            //   borderRadius: BorderRadius.circular(50),
            //   child: Container(
            //     color: const Color.fromARGB(204, 158, 158, 158),
            //     child:  ListTile(
            //       onTap: () {
            
            //       },
            //       leading: const CircleAvatar(
            //       radius: 25,
            //       backgroundImage: AssetImage('assets/musiconlogo.png')
            //       ),
            //       title: Text(data.playlistname),
            //       subtitle: Text('10'),
            //       trailing: Wrap(
            // children: const[
              
            // ],
            //       )
                
            //     ),
            //   ),
            // );
          
                }, 
                separatorBuilder: (context, index) {
                  return SizedBox(height: 15,);
                }, 
                itemCount: newlist.length): Center(child: headtext('No Playlist'));
            }),
          ),
        
        ),
      ),
    );
  }
}