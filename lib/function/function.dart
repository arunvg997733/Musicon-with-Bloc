import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/screen/mainscreen.dart';
import 'package:musicon/screen/namescreen.dart';
import 'package:musicon/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> setname(String name,context)async{
  if(name.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please Enter Name'),behavior: SnackBarBehavior.floating,)
    );
  }else{
    final SharedPreferences savename = await SharedPreferences.getInstance();
  savename.setString('name', name);
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>Mainscreen()),(route) => false,);
  }
  

}

Future<void> setbool()async{
  final SharedPreferences check = await SharedPreferences.getInstance();
  check.setBool('checkbool', true);
}

void checkname(context)async{
  await Future.delayed(const Duration(seconds: 3));
  final SharedPreferences check = await SharedPreferences.getInstance();
  final checkvalue = check.getBool('checkbool');
  if(checkvalue==true){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Mainscreen()));
  }else{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Namescreen()));
  }
}

bool favouritechecking(Songsmodel data){

  for(var element in favoritelistnotifier.value){
    if(data.id == element.id){
      return true;
    }
  }
  
  return false;

}

findsong(int songid){
  for(var element in allsongnotifierlist.value){
    if(songid == element.id){
      addtorecentdatabase(element);
      addtomostplayeddatabase(element);
      break;
    }
  }

}

playlistshowdialog(context){
  showDialog(context: context, builder: (ctx) {
    final playlistnamectr = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: const Color.fromARGB(255, 63, 63, 63),
      actionsAlignment: MainAxisAlignment.spaceAround,
      title:  Center(child: headtext('Create Play list')),
      content: TextField(
        controller: playlistnamectr,
        textAlign: TextAlign.center,decoration:InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)))),
      actions: [
        
        TextButton(onPressed: () {
          List<Songsmodel> newplaylist =[];
          // addtoplaylist(playlistnamectr.text, newplaylist);
          
          Navigator.pop(context);
        }, child: Text('Create')),
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text('Cancel'))
      ],
    );
  },);
}


// addtoplaylist(String name,List<Songsmodel> newlist){
// final newplaylist = Playlistmodel(playlistname: name, playlistarray: newlist);
// playlistnotifier.value.add(newplaylist);
// playlistnotifier.notifyListeners();
// }

