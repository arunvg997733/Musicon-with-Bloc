part of 'searchscreen_bloc.dart';

class SearchscreenState {
  List<Songsmodel> searchlist;
  SearchscreenState({required this.searchlist});
}
class SearchscreenInitial extends SearchscreenState{
  SearchscreenInitial():super(searchlist: allsongnotifierlist.value);
}


