import 'package:hive_flutter/adapters.dart';
part 'songsmodel.g.dart';

@HiveType(typeId: 1)
class Songsmodel{
  @HiveField(0)
  String name;
  @HiveField(1)
  String artist;
  @HiveField(2)
  String uri;
  @HiveField(3)
  int id;
  @HiveField(4)
  int duration;
  @HiveField(5)
  int count;


  Songsmodel({required this.name,required this.artist,required this.uri,required this.id,required this.duration,this.count=0});

  
}