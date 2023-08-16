part of 'searchscreen_bloc.dart';

@immutable
abstract class SearchscreenEvent {}

class Search extends SearchscreenEvent{
  final String text;
  Search({required this.text});
}
