part of 'navigationbar_bloc.dart';

@immutable
abstract class NavigationbarEvent {}

class OntapIndex extends NavigationbarEvent{
  final int index;
  OntapIndex({required this.index});
}
