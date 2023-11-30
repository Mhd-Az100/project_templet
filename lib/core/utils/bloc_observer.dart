import 'package:flutter_bloc/flutter_bloc.dart';
import 'logging_service.dart';

class MyGlobalObserver extends BlocObserver {
  final logging = LogService();
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logging.warning('${bloc.runtimeType} bloc created');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logging.warning('${bloc.runtimeType} bloc closed');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logging.wtf('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logging.wtf('${bloc.runtimeType}');
    logging.debug(change.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logging.wtf('${bloc.runtimeType}');
    logging.verbose(transition.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logging.error('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
