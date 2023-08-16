import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicon/application/playlist/playlist_bloc.dart';
import 'package:musicon/infrastructure/db_function.dart/db_function.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/presentation/playlist/newplaylistscreen.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Playlistscreen extends StatelessWidget {
  const Playlistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    playlistdatabasetolist();
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image:AssetImage('assets/Background.png'),
            fit: BoxFit.cover,
            )
          ),
          width: double.infinity,
         
          child: BlocBuilder<PlaylistBloc, PlaylistState>(
            builder: (context, state) {
              return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: state.playlist.isNotEmpty ? ListView.separated(
                        itemBuilder: (context, index) {
                          final data = state.playlist[index];
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
                          subtitle: data.playlistarray.isNotEmpty ? Text('${data.playlistarray.length.toString()} Songs'):const Text('Empty'),
                          trailing: Wrap(
                          children: [
                            IconButton(onPressed: () {
                              playlistshowdialogupdate(context,data,index);
                            }, icon: const Icon(Icons.edit)),
                            
                            IconButton(onPressed: () {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  title: const Text('Do you want to delete'),
                                  actions: [
                                    TextButton(onPressed: () {
                                      // deleteplaylistdatabase(data);
                                      context.read<PlaylistBloc>().add(Playlistdelete(data: data));
                                      Navigator.pop(context);
                                    }, child: const Text('Yes')),
                                    TextButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: const Text('No'))
          
                                  ],
                                );
                              },);
                              
                            }, icon: const Icon(Icons.delete)),
                          ],
                  )
                        
                ),
              ),
            );
                          
                        }, 
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 15,);
                        }, 
                        itemCount: state.playlist.length): Center(child: headtext('No Playlist')),
                    );
            },
          ),
        
        ),
      ),
    );
  }
}