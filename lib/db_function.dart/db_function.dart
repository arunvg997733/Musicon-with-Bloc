import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ALLSONGLIST//

addallsongtodata(SongModel data)async{

  final allsongdatabase = await Hive.openBox<Songsmodel>('allsong');

  final newsong = Songsmodel(name: data.displayNameWOExt, artist: data.artist!, uri:data.uri!, id: data.id, duration: data.duration!);
  bool flag = true;

  for(var element in allsongdatabase.values){
    if(newsong.id == element.id){
      flag = false;
    }
  }
  if(flag == true){
    allsongdatabase.add(newsong);
  }
  

}

Allsongdatabasetolist()async{
  final allsongdatabase = await Hive.openBox<Songsmodel>('allsong');
  allsongnotifierlist.value.clear();
  allsongnotifierlist.value.addAll(allsongdatabase.values);
  allsongnotifierlist.notifyListeners();
}


//FAVOURITELIST//


addtofavoritedatabase(Songsmodel data,context)async{
  final favoriteDB = await Hive.openBox<Songsmodel>('favoriteDB');

  bool flag = true;

  for(var element in favoriteDB.values){

    if(data.id == element.id){

      flag = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Already Added'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          )
        );

    }
    

  }

  if(flag == true){
      favoriteDB.add(data);
      favouritedatabasetolist();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to Favouritelist'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          )
        );
    }
}

 favouritedatabasetolist()async{
   final favouriteDB = await Hive.openBox<Songsmodel>('favoriteDB');
   favoritelistnotifier.value.clear();
   favoritelistnotifier.value.addAll(favouriteDB.values);
   favoritelistnotifier.notifyListeners();
 }

deletefavouritelist(int index)async{
  final favouriteDB = await Hive.box<Songsmodel>('favoriteDB');
  favouriteDB.deleteAt(index);
  favouritedatabasetolist();

}

deletefavouritelistontap(Songsmodel data,context)async{
  final favouriteDB = await Hive.box<Songsmodel>('favoriteDB');
  int index=0;
  for(var element in favouriteDB.values){

    if(data.id == element.id){
      break;
    }
    index++;
  }

  favouriteDB.deleteAt(index);
  ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleted from Favourite list'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),)
                          );
  favouritedatabasetolist();
}


// RECENT DATABASE//

addtorecentdatabase(Songsmodel data)async{
  final recentDB = await Hive.openBox<Songsmodel>('recentDB');
  int count=0;

  for(var element in recentDB.values){
    count++;
  }

  if(count>4){
    recentDB.deleteAt(0);
  }
  if(recentDB.values.isEmpty){
    recentDB.add(data);
  }
  int number =0;

  for(var element in recentDB.values){
    if( data.id == element.id){
      recentDB.deleteAt(number);
    }
    number++;
  }

  recentDB.add(data);
  recentdatabasetolist();
}

recentdatabasetolist()async{
  final recentDB = await Hive.openBox<Songsmodel>('recentDB');
  recentlistnotifier.value.clear();
  recentlistnotifier.value.addAll(recentDB.values);
  recentlistnotifier.value = List<Songsmodel>.from(recentlistnotifier.value.reversed);
  recentlistnotifier.notifyListeners();
}


// MOSTPLAYED LIST//

addtomostplayeddatabase(Songsmodel data)async{
  final mostplayedDB =  await Hive.openBox<Songsmodel>('mostplayedDB');
  data.count = data.count+1;

  int count=0;

  for(var element in mostplayedDB.values){
    count++;
  }

  if(count>4){
    mostplayedDB.deleteAt(0);
  }

  int index = 0;

  for(var element in mostplayedDB.values){
    if(data.id == element.id){
      mostplayedDB.deleteAt(index);
    }
    index++;
  }

  final newsong = Songsmodel(name: data.name, artist: data.artist, uri: data.uri, id: data.id, duration: data.duration,count: data.count);
  mostplayedDB.add(newsong);
  mostplayeddatabasetolist();
}

mostplayeddatabasetolist()async{
  final mostplayedDB =  await Hive.openBox<Songsmodel>('mostplayedDB');
  mostplayedlistnotifier.value.clear();
  for(var element in  mostplayedDB.values){
    if(element.count>10){
      mostplayedlistnotifier.value.add(element);
    }
  }
  for(int i=0;i<mostplayedlistnotifier.value.length;i++){
    for(int j=i+1;j<mostplayedlistnotifier.value.length;j++){
      if(mostplayedlistnotifier.value[i].count<mostplayedlistnotifier.value[j].count){
        Songsmodel temp = mostplayedlistnotifier.value[i];
        mostplayedlistnotifier.value[i] = mostplayedlistnotifier.value[j];
        mostplayedlistnotifier.value[j] = temp;
      }
    }
  }
  mostplayedlistnotifier.notifyListeners();
}





