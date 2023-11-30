import 'package:logger/logger.dart';

class LogService {
  Logger log = Logger();
  // ignore: constant_identifier_names
  static const _DEBUG = true;

  void debug(String message) {
    if (_DEBUG) {
      log.d(message);
    } else {
      return;
    }
  }

  void error(String message) {
    if (_DEBUG) {
      log.e(message);
    } else {
      return;
    }
  }

  void info(String message) {
    if (_DEBUG) {
      log.i(message);
    } else {
      return;
    }
  }

  void logg(Level level, String message) {
    if (_DEBUG) {
      log.log(level, message);
    } else {
      return;
    }
  }

  void verbose(String message) {
    if (_DEBUG) {
      // ignore: deprecated_member_use
      log.v(message);
    } else {
      return;
    }
  }

  void warning(String message) {
    if (_DEBUG) {
      log.w(message);
    } else {
      return;
    }
  }

  void wtf(String message) {
    if (_DEBUG) {
      // ignore: deprecated_member_use
      log.wtf(message);
    } else {
      return;
    }
  }
}
