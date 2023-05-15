import 'package:hive_flutter/adapters.dart';
import 'package:musicon/model/songsmodel.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 2)
class Playlistmodel{
  @HiveField(0)
  String playlistname;
  @HiveField(1)
  List<Songsmodel> playlistarray;

  Playlistmodel({required this.playlistname,required this.playlistarray});
}