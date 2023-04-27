import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';



final audioquery = OnAudioQuery();
final audioPlayer = AssetsAudioPlayer();

List<SongModel> allsonglist = [];
List<SongModel> mp3songslist =[];



checkpermission()async{
  final permission = await Permission.storage.request();
  Allsongdatabasetolist();
  if(permission.isGranted){
    allsonglist = await audioquery.querySongs();

    for(var element in allsonglist){
      if(element.fileExtension == 'mp3'){
        mp3songslist.add(element);
      }
    }
    for(var element in mp3songslist){
      addallsongtodata(element);
    }
  }else{
    checkpermission();
  }
}



playsong(uri){

  List <Audio> audio = 
  // audioPlayer.open(Audio.file(uri),showNotification: true);
  audioPlayer.open(Playlist(audios:));
  // audioPlayer.play();

  audioPlayer.play();
}