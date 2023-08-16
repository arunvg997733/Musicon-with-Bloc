import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/application/newplaylist/newplaylist_bloc.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Newplaylistscreen extends StatelessWidget {
   Newplaylistscreen({super.key,required this.data});
  final Playlistmodel data;

  @override
  Widget build(BuildContext context) {
    newplaylistnotifier = data.playlistarray;
    context.read<NewplaylistBloc>().add(Newplaylistshow(newlist: data.playlistarray));
    return Scaffold(
      appBar: AppBar(
        title: headtext(data.playlistname),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions:[
          IconButton(onPressed: () {
            allsongbottomsheet(context, data.playlistname);
          }, icon: const Icon(Icons.add_circle_outline,color: Colors.white,))
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
        child: BlocBuilder<NewplaylistBloc, NewplaylistState>(
          builder: (context, state) {
            return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: data.playlistarray.isNotEmpty ? ListView.separated(
                  itemBuilder: (context, index) {
                    final songdata = state.newlist[index];
                    return songbar4(songdata, context, index, data,);
                  }, 
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15,);
                  }, 
                  itemCount:state.newlist.length ):Center(child: headtext('No Songs'))
                );
          },
        ),
      )
    );
  }
}