import 'package:logger/logger.dart';

import 'printers/single_pretty_printer.dart';

/// Use instances of roggle to send log messages to the [LogPrinter].
class Roggle {
  /// Create a new instance of Roggle.
  ///
  /// You can provide a custom [printer], [filter] and [output]. Otherwise the
  /// defaults: [SinglePrettyPrinter], [DevelopmentFilter] and [ConsoleOutput]
  /// will be used.
  Roggle({
    LogFilter? filter,
    LogPrinter? printer,
    LogOutput? output,
    Level? level,
  })  : _filter = filter ?? DevelopmentFilter(),
        _printer = printer ?? SinglePrettyPrinter(),
        _output = output ?? ConsoleOutput() {
    _filter.init();
    // ignore: cascade_invocations
    _filter.level = level ?? Logger.level;
    _printer.init();
    _output.init();
  }

  /// The current logging level of the app.
  ///
  /// All logs with levels below this level will be omitted.
  static Level level = Level.verbose;

  final LogFilter _filter;
  LogFilter get filter => _filter;

  final LogPrinter _printer;
  LogPrinter get printer => _printer;

  final LogOutput _output;
  LogOutput get output => _output;

  bool _active = true;
  bool get active => _active;

  /// Log a message at level [Level.verbose].
  List<String> v(Object message, [Object? error, StackTrace? stackTrace]) {
    return log(Level.verbose, message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  List<String> d(Object message, [Object? error, StackTrace? stackTrace]) {
    return log(Level.debug, message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  List<String> i(Object message, [Object? error, StackTrace? stackTrace]) {
    return log(Level.info, message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  List<String> w(Object message, [Object? error, StackTrace? stackTrace]) {
    return log(Level.warning, message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  List<String> e(Object message, [Object? error, StackTrace? stackTrace]) {
    return log(Level.error, message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  List<String> wtf(Object message, [Object? error, StackTrace? stackTrace]) {
    return log(Level.wtf, message, error, stackTrace);
  }

  /// Log a message with [level].
  List<String> log(
    Level level,
    Object message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (!_active) {
      throw ArgumentError('Logger has already been closed.');
    } else if (error != null && error is StackTrace) {
      throw ArgumentError('Error parameter cannot take a StackTrace!');
    } else if (level == Level.nothing) {
      throw ArgumentError('Log events cannot have Level.nothing');
    }
    var output = <String>[];
    final logEvent = LogEvent(level, message, error, stackTrace);
    if (_filter.shouldLog(logEvent)) {
      output = _printer.log(logEvent);

      if (output.isNotEmpty) {
        final outputEvent = OutputEvent(level, output);
        // I didn't try to catch it because I wanted
        // to stop the app on purpose.
        _output.output(outputEvent);
      }
    }
    return output;
  }

  /// Closes the logger and releases all resources.
  void close() {
    _active = false;
    _filter.destroy();
    _printer.destroy();
    _output.destroy();
  }
}
