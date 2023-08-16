part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class Playlistadd extends PlaylistEvent{
  final String name;
  Playlistadd({required this.name});
}

class Playlistdelete extends PlaylistEvent{
  final Playlistmodel data;
  Playlistdelete({required this.data});
}

class Playlistupdate extends PlaylistEvent{
  final String name;
  final int index;
  final List <Songsmodel> newlist;
  Playlistupdate({required this.name,required this.index,required this.newlist});
}
