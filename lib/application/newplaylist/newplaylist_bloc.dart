import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/infrastructure/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';

part 'newplaylist_event.dart';
part 'newplaylist_state.dart';

class NewplaylistBloc extends Bloc<NewplaylistEvent, NewplaylistState> {
  NewplaylistBloc() : super(NewplaylistInitial()) {
    on<NewplaylistAdd>((event, emit) {
     songaddtoplaylistdatabase(event.listname, event.data);
     return emit(NewplaylistState(newlist: newplaylistnotifier));
    });

    on<Newplaylistshow>((event, emit) {
     return emit(NewplaylistState(newlist: event.newlist));
    });

    on<Newplaylistdelete>((event, emit) {
     songsdeletefromplaylist(event.data,event.listname);
     return emit(NewplaylistState(newlist: newplaylistnotifier));
    });

    
  }
}
