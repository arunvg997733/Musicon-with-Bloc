part of 'navigationbar_bloc.dart';

class NavigationbarState {
  int index;
  NavigationbarState({required this.index});
}

class NavigationbarInitial extends NavigationbarState{
  NavigationbarInitial() : super(index: 0);
}
