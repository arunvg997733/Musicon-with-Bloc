part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class favouriteadd extends FavouriteEvent{
 final Songsmodel data;
  favouriteadd({required this.data});
}

class favouritedelete extends FavouriteEvent{
 final Songsmodel data;
  favouritedelete({required this.data});
}
