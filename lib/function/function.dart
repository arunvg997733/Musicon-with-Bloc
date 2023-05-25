import 'package:flutter/material.dart';
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
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const Mainscreen()),(route) => false,);
  }
  

}

Future<void> setbool()async{
  final SharedPreferences check = await SharedPreferences.getInstance();
  check.setBool('checkbool', true);
}

void checkname(context)async{
  // await Future.delayed(const Duration(seconds: 3));
  final SharedPreferences check = await SharedPreferences.getInstance();
  final checkvalue = check.getBool('checkbool');
  if(checkvalue==true){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const Mainscreen()));
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: const Color.fromARGB(255, 63, 63, 63),
      actionsAlignment: MainAxisAlignment.spaceAround,
      title:  Center(child: headtext('Create Play list')),
      content: TextField(
        textCapitalization: TextCapitalization.words,
        controller: playlistnamectr,
        textAlign: TextAlign.center,decoration:InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)))),
      actions: [
        
        TextButton(onPressed: () {
          List<Songsmodel> newplaylist =[];
          if(playlistnamectr.text.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Please Enter Valid Name'),behavior: SnackBarBehavior.floating,));
          }else{
            addplaylisttodatabase(playlistnamectr.text, newplaylist,context);
            Navigator.pop(context);
          }
          
          
        }, child: const Text('Create')),
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Text('Cancel'))
      ],
    );
  },);
}

playlistbottomsheet(context,Songsmodel songdata){
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
    context: context, 
    builder: (context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Color.fromARGB(216, 0, 0, 0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            headtext('Playlist'),
            IconButton(onPressed: () {
              playlistshowdialog(context);
            }, icon: const Icon(Icons.add_box_outlined,color: Colors.white,)),
      
            Expanded(child: ValueListenableBuilder(valueListenable: playlistnotifier, builder:(BuildContext ctx, List<Playlistmodel> newlist, Widget? child){
                return playlistnotifier.value.isNotEmpty ? ListView.separated(
                  itemBuilder: (context, index) {
                    final data = newlist[index];
                    return playlistbar(data,context,songdata);
                  }, 
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15,);
                  }, 
                  itemCount: newlist.length):Center(child: headtext('No Playlist'));
              }),
              )
          ],
        ),
      ),
    );
  },
  );
}

allsongbottomsheet(context,String listname){
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
    backgroundColor: Colors.transparent,
    context: context, 
    builder: (context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        color: Color.fromARGB(148, 0, 0, 0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            headtext('All Songs'),
            const SizedBox(height: 15,),
            Expanded(
              child:allsongnotifierlist.value.isNotEmpty ? ListView.separated(
                itemBuilder: (context, index) {
                  final data = allsongnotifierlist.value[index];
                  return songbar5(data, context, index,listname);
                }, 
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 15,);
                }, 
                itemCount: allsongnotifierlist.value.length):Center(child: headtext('No Songs'))
            ),
          ],
        ),
      ),
    );
  },);
}


Songsmodel findsongwithid(int songid){
  late Songsmodel data;
  for(var element in allsongnotifierlist.value){
    
    if(songid == element.id){
     
    data =  element;
    }
  }

  return data;
  
}


playlistshowdialogupdate(context,Playlistmodel data,int index){
  showDialog(context: context, builder: (ctx) {
    TextEditingController playlistnamectr = TextEditingController();
    playlistnamectr.text = data.playlistname;
    
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: const Color.fromARGB(255, 63, 63, 63),
      actionsAlignment: MainAxisAlignment.spaceAround,
      title:  Center(child: headtext('Edit Play list')),
      content: TextField(
        textCapitalization: TextCapitalization.words,
        controller: playlistnamectr,
        textAlign: TextAlign.center,decoration:InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)))),
      actions: [
        
        TextButton(onPressed: () {
          
          if(playlistnamectr.text.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Please Enter Valid Name'),behavior: SnackBarBehavior.floating,));
          }else{
            List<Songsmodel> newplaylist = data.playlistarray;
            updateplaylisttodatabase(playlistnamectr.text, newplaylist,context,index);
            Navigator.pop(context);
          }
          
          
        }, child: const Text('Upadate')),
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Text('Cancel'))
      ],
    );
  },);
}


