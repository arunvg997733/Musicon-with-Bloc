part of 'newplaylist_bloc.dart';

class NewplaylistState {
  List<Songsmodel> newlist;
  NewplaylistState({required this.newlist});
}

class NewplaylistInitial extends NewplaylistState{
  NewplaylistInitial(): super(newlist:newplaylistnotifier);
}

