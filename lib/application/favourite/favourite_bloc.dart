import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/infrastructure/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<favouriteadd>((event, emit) {
      addtofavoritedatabase(event.data,);
      return emit(FavouriteState(favouritelist: favoritelistnotifier.value));
    });

    on<favouritedelete>((event, emit) {
      deletefavouritelistontap(event.data);
      return emit(FavouriteState(favouritelist: favoritelistnotifier.value));
    });
  }
}
