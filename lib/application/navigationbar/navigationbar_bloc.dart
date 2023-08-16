import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigationbar_event.dart';
part 'navigationbar_state.dart';

class NavigationbarBloc extends Bloc<NavigationbarEvent, NavigationbarState> {
  NavigationbarBloc() : super(NavigationbarInitial()) {
    on<OntapIndex>((event, emit) {
      return emit(NavigationbarState(index: event.index));
    });
  }
}
