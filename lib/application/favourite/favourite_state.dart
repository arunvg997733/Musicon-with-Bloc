part of 'favourite_bloc.dart';

class FavouriteState {
  List<Songsmodel> favouritelist;
  FavouriteState({required this.favouritelist});

}
class FavouriteInitial extends FavouriteState{
  
  FavouriteInitial(): super(favouritelist: favoritelistnotifier.value);
}



