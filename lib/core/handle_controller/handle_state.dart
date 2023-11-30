part of 'handle_cubit.dart';

abstract class HandleState extends Equatable {
  const HandleState();

  @override
  List<Object> get props => [];
}

class HandleInitial extends HandleState {}

class StopLoaderState extends HandleState {}

class ErrorState extends HandleState {
  final String message;

  const ErrorState(this.message);
  @override
  List<Object> get props => [message];
}

class SuccessState extends HandleState {
  final String message;

  const SuccessState(this.message);
  @override
  List<Object> get props => [message];
}
