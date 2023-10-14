import 'package:logger/logger.dart';

import 'outputs/dump_output.dart';
import 'printers/crashlytics_printer.dart';
import 'printers/single_pretty_printer.dart';

typedef LogCallback = void Function(LogEvent event);

typedef OutputCallback = void Function(OutputEvent event);

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
  })  : _filter = filter ?? defaultFilter(),
        _printer = printer ?? defaultPrinter(),
        _output = output ?? defaultOutput() {
    _filter.init();
    // ignore: cascade_invocations
    _filter.level = level ?? Roggle.level;
    _printer.init();
    _output.init();
  }

  /// Create a new instance of Roggle for Crashlytics.
  ///
  /// You can provide a custom [printer].
  factory Roggle.crashlytics({
    required CrashlyticsPrinter printer,
  }) =>
      Roggle(
        filter: ProductionFilter(),
        printer: printer,
        output: DumpOutput(),
      );

  /// The current logging level of the app.
  ///
  /// All logs with levels below this level will be omitted.
  static Level level = Level.trace;

  /// The current default implementation of log filter.
  static LogFilter Function() defaultFilter = DevelopmentFilter.new;

  /// The current default implementation of log printer.
  static LogPrinter Function() defaultPrinter = SinglePrettyPrinter.new;

  /// The current default implementation of log output.
  static LogOutput Function() defaultOutput = ConsoleOutput.new;

  static final Set<LogCallback> _logCallbacks = {};

  static final Set<OutputCallback> _outputCallbacks = {};

  final LogFilter _filter;
  LogFilter get filter => _filter;

  final LogPrinter _printer;
  LogPrinter get printer => _printer;

  final LogOutput _output;
  LogOutput get output => _output;

  bool _active = true;
  @Deprecated(
    '[active] is being deprecated, use [isClosed()] instead.',
  )
  bool get active => _active;

  /// Log a message at level [Level.verbose].
  @Deprecated(
    '[Level.verbose] is being deprecated in favor of [Level.trace], '
    'use [t] instead.',
  )
  void v(
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    t(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.trace].
  void t(
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.trace, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.debug].
  void d(
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.debug, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.info].
  void i(
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.info, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.warning].
  void w(
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(
      Level.warning,
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.error].
  void e(
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.error, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.wtf].
  @Deprecated(
    '[Level.wtf] is being deprecated in favor of [Level.fatal], '
    'use [f] instead.',
  )
  void wtf(
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    f(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.fatal].
  void f(
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.fatal, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message with [level].
  void log(
    Level level,
    Object? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_active) {
      throw ArgumentError('Logger has already been closed.');
    } else if (error != null && error is StackTrace) {
      throw ArgumentError('Error parameter cannot take a StackTrace!');
    } else if (level == Level.all) {
      throw ArgumentError('Log events cannot have Level.all');
    } else if (level == Level.off) {
      throw ArgumentError('Log events cannot have Level.off');
      // ignore: deprecated_member_use
    } else if (level == Level.nothing) {
      throw ArgumentError('Log events cannot have Level.nothing');
      // ignore: deprecated_member_use
    } else if (level == Level.verbose) {
      throw ArgumentError('Log events cannot have Level.verbose');
      // ignore: deprecated_member_use
    } else if (level == Level.wtf) {
      throw ArgumentError('Log events cannot have Level.wtf');
    }
    final logEvent = LogEvent(
      level,
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
    for (final callback in _logCallbacks) {
      callback(logEvent);
    }

    if (_filter.shouldLog(logEvent)) {
      final output = _printer.log(logEvent);

      if (output.isNotEmpty) {
        final outputEvent = OutputEvent(logEvent, output);
        for (final callback in _outputCallbacks) {
          callback(outputEvent);
        }
        // I didn't try to catch it because I wanted
        // to stop the app on purpose.
        _output.output(outputEvent);
      }
    }
  }

  bool isClosed() {
    return !_active;
  }

  /// Closes the logger and releases all resources.
  Future<void> close() async {
    if (!_active) {
      return;
    }

    _active = false;
    await _filter.destroy();
    await _printer.destroy();
    await _output.destroy();
  }

  /// Register a [LogCallback] which is called for each new [LogEvent].
  static void addLogListener(LogCallback callback) {
    _logCallbacks.add(callback);
  }

  /// Removes a [LogCallback] which was previously registered.
  ///
  /// Returns whether the callback was successfully removed.
  static bool removeLogListener(LogCallback callback) {
    return _logCallbacks.remove(callback);
  }

  /// Register an [OutputCallback] which is called for each new [OutputEvent].
  static void addOutputListener(OutputCallback callback) {
    _outputCallbacks.add(callback);
  }

  /// Removes a [OutputCallback] which was previously registered.
  ///
  /// Returns whether the callback was successfully removed.
  static void removeOutputListener(OutputCallback callback) {
    _outputCallbacks.remove(callback);
  }
}
