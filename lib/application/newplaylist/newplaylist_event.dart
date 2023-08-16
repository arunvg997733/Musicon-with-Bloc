part of 'newplaylist_bloc.dart';

@immutable
abstract class NewplaylistEvent {}

class NewplaylistAdd extends NewplaylistEvent{
  final String listname;
  final Songsmodel data;
  NewplaylistAdd({required this.listname,required this.data});
} 

class Newplaylistdelete extends NewplaylistEvent{
  final String listname;
  final Songsmodel data;
  Newplaylistdelete({required this.listname,required this.data});
} 

class Newplaylistshow extends NewplaylistEvent{
  final List<Songsmodel> newlist;
  Newplaylistshow({required this.newlist});
} 


