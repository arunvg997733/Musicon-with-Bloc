import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/player/playercontroller.dart';



ValueNotifier<List<Songsmodel>> allsongnotifierlist = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> favoritelistnotifier = ValueNotifier([]);

ValueNotifier<bool> isfavouritecheck = ValueNotifier(true); 

ValueNotifier<List<Songsmodel>> recentlistnotifier = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> mostplayedlistnotifier = ValueNotifier([]);

List templist = [];

int number = 0;


addtorecent(Songsmodel data){

  // int number = 0;

  bool flag = true;

  for(var element in recentlistnotifier.value){

    if(data.id == element.id){
      flag = false;
    }



  }

  if(flag == true){

    //   templist.add(data);
    
    // recentlistnotifier.value.clear();

    // for(int i=templist.length-1;i>=0;i--){
    //   recentlistnotifier.value.add(templist[i]);
    // }

    recentlistnotifier.value.add(data);
    int n=recentlistnotifier.value.length;

    for(int i=0;i<n;i++){
      Songsmodel temp = recentlistnotifier.value[i];
      

    }

    

   

  }



}

