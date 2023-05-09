import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/screen/allsongscreen.dart';
import 'package:musicon/screen/homescreen.dart';
import 'package:musicon/screen/playlistscreen.dart';
import 'package:musicon/screen/searchscreen.dart';
import 'package:musicon/screen/settingsscreen.dart';
import 'package:musicon/widgets/widget.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {

  int currentindex=0;
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: headtext(pagenames[currentindex]),
        leading:Builder(builder: (context) {
          return IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: const Icon(Icons.settings,color: Colors.white,));
        },),

        
         
        actions: <Widget>[
          currentindex ==2?IconButton(onPressed: (){
            playlistshowdialog(context);
          }, icon: const Icon(Icons.add_circle_outline,color: Colors.white,)):
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Searchscreen()));
          }, icon: const Icon(Icons.search,color: Colors.white,))

        ],
        centerTitle: true,
      ),
      extendBody: true,
      body: pages[currentindex],
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.bounceOut,
        index: currentindex,
        backgroundColor: const Color.fromARGB(163, 0, 0, 0),
        buttonBackgroundColor: Colors.amber,
        color: const Color.fromARGB(255, 63, 63, 63),
        height: 55,
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
        },
        items: const [
          Icon(Icons.library_music_outlined),
          Icon(Icons.home_outlined),
          Icon(Icons.playlist_add_rounded),
      ]),
    );
  }
}