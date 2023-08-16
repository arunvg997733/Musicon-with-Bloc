part of 'playlist_bloc.dart';

class PlaylistState {
  List <Playlistmodel> playlist;
  PlaylistState({required this.playlist});
}

class PlaylistInitial extends PlaylistState{
  PlaylistInitial() : super(playlist: playlistnotifier);
}


