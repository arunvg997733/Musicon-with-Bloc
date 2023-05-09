import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/screen/mainscreen.dart';
import 'package:musicon/screen/namescreen.dart';
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
    return AlertDialog(
      title:  Text('Create Play list'),
      content: Column(
        children: [
          TextField(),
          ElevatedButton(onPressed: () {
            
          }, child: Text('Submit'))
        ],
      ),
    );
  },);
}

