import 'package:hive_flutter/adapters.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

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




