// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'handle_state.dart';

class HandleCubit extends Cubit<HandleState> {
  HandleCubit() : super(HandleInitial());
  // stopLoading() {
  //   emit(StopLoaderState());
  // }

  errorOperation(String msg) {
    emit(StopLoaderState());
    emit(ErrorState(msg));
  }

  successOperation(String msg) {
    emit(StopLoaderState());
    emit(SuccessState(msg));
  }
}
