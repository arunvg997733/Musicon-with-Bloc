import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/infrastructure/db_function.dart/db_function.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(PlaylistInitial()) {
    on<Playlistadd>((event, emit) {
      List<Songsmodel> newplaylist =[];
      addplaylisttodatabase(event.name, newplaylist);
      return emit(PlaylistState(playlist: playlistnotifier));
    });

    on<Playlistdelete>((event, emit) {
      deleteplaylistdatabase(event.data);
      return emit(PlaylistState(playlist: playlistnotifier));
    });

    on<Playlistupdate>((event, emit) {
      updateplaylisttodatabase(event.name, event.newlist, event.index);
      return emit(PlaylistState(playlist: playlistnotifier));
    });

    
  }
}
