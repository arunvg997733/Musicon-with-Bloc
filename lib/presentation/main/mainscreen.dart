import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicon/application/navigationbar/navigationbar_bloc.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/presentation/allsongs/allsongscreen.dart';
import 'package:musicon/presentation/home/homescreen.dart';
import 'package:musicon/presentation/playlist/playlistscreen.dart';
import 'package:musicon/presentation/search/searchscreen.dart';
import 'package:musicon/presentation/settings/settingsscreen.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Mainscreen extends StatelessWidget {
   Mainscreen({super.key});

  final pages = const [
    Allsongscreen(),
    Homescreen(),
    Playlistscreen()

  ];

  final pagenames = [
    'All Songs',
    'Home',
    'Play List'
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color.fromARGB(158, 0, 0, 0)), 
        child: Settingscreen()
        ),
      appBar: PreferredSize(
       preferredSize: Size(50, 50),
        child: BlocBuilder<NavigationbarBloc, NavigationbarState>(
          builder: (ctx, state) {
            return AppBar(
                  backgroundColor: Colors.black,
                  title: headtext(pagenames[state.index]),
                  leading:Builder(builder: (context) {
                    return IconButton(onPressed: (){
                    Scaffold.of(context).openDrawer();
                  }, icon: const Icon(Icons.settings,color: Colors.white,));
                  },),
              
                  
                   
                  actions: <Widget>[
                    state.index ==2?IconButton(onPressed: (){
                      playlistshowdialog(context,);
                    }, icon: const Icon(Icons.add_circle_outline,color: Colors.white,)):
                    IconButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Searchscreen()));
                    }, icon: const Icon(Icons.search,color: Colors.white,))
              
                  ],
                  centerTitle: true,
                );
          },
        ),
      ),
      extendBody: true,
      body: BlocBuilder<NavigationbarBloc, NavigationbarState>(
        builder: (context, state) {
          return pages[state.index];
        },
      ),
      bottomNavigationBar: 
      Wrap(
        children: [
          const Minimusicplayer(),
          BlocBuilder<NavigationbarBloc, NavigationbarState>(
            builder: (context, state) {
              return CurvedNavigationBar(
                      animationCurve: Curves.bounceOut,
                      index: 0,
                      backgroundColor: Colors.black,
                      buttonBackgroundColor: Colors.amber,
                      color: const Color.fromARGB(255, 63, 63, 63),
                      height: 55,
                      onTap: (value) {
                        context.read<NavigationbarBloc>().add(OntapIndex(index: value));
                      },
                      items: const [
                        Icon(Icons.library_music_outlined),
                        Icon(Icons.home_outlined),
                        Icon(Icons.playlist_add_rounded),
                    ]);
            },
          ),
        ],
      ),
    );
  }
}