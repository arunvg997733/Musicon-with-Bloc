import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/model/songsmodel.dart';

part 'searchscreen_event.dart';
part 'searchscreen_state.dart';

class SearchscreenBloc extends Bloc<SearchscreenEvent, SearchscreenState> {
  SearchscreenBloc() : super(SearchscreenInitial()) {
    on<Search>((event, emit) {

      List<Songsmodel> newlist = allsongnotifierlist.value.where((element) => element.name.toLowerCase().contains(event.text.toLowerCase())).toList();
      return emit(SearchscreenState(searchlist: newlist));
    });
  }
}
