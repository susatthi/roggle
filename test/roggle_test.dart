// ignore: lines_longer_than_80_chars
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'dart:math';

import 'package:roggle/roggle.dart';
import 'package:test/test.dart';

import 'test_utils/utils.dart';

typedef PrinterCallback = List<String> Function(
  Level level,
  dynamic message,
  dynamic time,
  dynamic error,
  StackTrace? stackTrace,
);

class _AlwaysFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}

class _NeverFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => false;
}

class _CallbackPrinter extends LogPrinter {
  _CallbackPrinter(this.callback);

  final PrinterCallback callback;

  @override
  List<String> log(LogEvent event) {
    return callback(
      event.level,
      event.message,
      event.time,
      event.error,
      event.stackTrace,
    );
  }
}

void main() {
  Level? printedLevel;
  dynamic printedMessage;
  dynamic printedTime;
  dynamic printedError;
  StackTrace? printedStackTrace;
  final callbackPrinter =
      _CallbackPrinter((l, dynamic m, dynamic t, dynamic e, s) {
    printedLevel = l;
    printedMessage = m;
    printedTime = t;
    printedError = e;
    printedStackTrace = s;
    return [];
  });

  setUp(() {
    printedLevel = null;
    printedMessage = null;
    printedTime = null;
    printedError = null;
    printedStackTrace = null;
  });

  group('Constructor', () {
    test('default', () {
      Roggle().d('some message');
    });
    test('filter', () {
      Roggle(filter: _NeverFilter(), printer: callbackPrinter)
          .log(Level.debug, 'Some message');

      expect(printedMessage, null);
    });
  });

  group('factory Roggle.crashlytics()', () {
    test('default', () {
      Roggle.crashlytics(
        printer: CrashlyticsPrinter(
          errorLevel: Level.off,
          onError: (_) {},
        ),
      ).d('some message');
    });
  });

  test('Roggle.log', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);

    final levels = getAvailableLogLevel();
    for (final level in levels) {
      var message = Random().nextInt(999999999).toString();
      logger.log(level, message);
      expect(printedLevel, level);
      expect(printedMessage, message);
      expect(printedTime, isNotNull);
      expect(printedError, null);
      expect(printedStackTrace, null);

      logger.log(level, null);
      expect(printedLevel, level);
      expect(printedMessage, null);
      expect(printedTime, isNotNull);
      expect(printedError, null);
      expect(printedStackTrace, null);

      // 2023/10/14 09:00:00
      final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
      logger.log(level, message, time: time);
      expect(printedLevel, level);
      expect(printedMessage, message);
      expect(printedTime, time);
      expect(printedError, null);
      expect(printedStackTrace, null);

      message = Random().nextInt(999999999).toString();
      logger.log(level, message, error: 'MyError');
      expect(printedLevel, level);
      expect(printedMessage, message);
      expect(printedTime, isNotNull);
      expect(printedError, 'MyError');
      expect(printedStackTrace, null);

      message = Random().nextInt(999999999).toString();
      final stackTrace = StackTrace.current;
      logger.log(level, message, error: 'MyError', stackTrace: stackTrace);
      expect(printedLevel, level);
      expect(printedMessage, message);
      expect(printedTime, isNotNull);
      expect(printedError, 'MyError');
      expect(printedStackTrace, stackTrace);
    }

    expect(
      () => logger.log(Level.trace, 'Test', error: StackTrace.current),
      throwsArgumentError,
    );

    expect(() => logger.log(Level.verbose, 'Test'), throwsArgumentError);
    expect(() => logger.log(Level.wtf, 'Test'), throwsArgumentError);
    expect(() => logger.log(Level.off, 'Test'), throwsArgumentError);
    expect(() => logger.log(Level.all, 'Test'), throwsArgumentError);
    expect(() => logger.log(Level.nothing, 'Test'), throwsArgumentError);

    logger.close();
    expect(() => logger.log(Level.trace, 'Test'), throwsArgumentError);

    // Execute close() twice
    logger.close();
    expect(() => logger.log(Level.trace, 'Test'), throwsArgumentError);
  });

  test('Roggle.v', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
    final stackTrace = StackTrace.current;
    logger.v('Test', time: time, error: 'Error', stackTrace: stackTrace);
    expect(printedLevel, Level.trace);
    expect(printedTime, time);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);

    logger.v(null);
    expect(printedLevel, Level.trace);
    expect(printedTime, isNotNull);
    expect(printedMessage, null);
    expect(printedError, null);
    expect(printedStackTrace, null);
  });

  test('Roggle.t', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
    final stackTrace = StackTrace.current;
    logger.t('Test', time: time, error: 'Error', stackTrace: stackTrace);
    expect(printedLevel, Level.trace);
    expect(printedTime, time);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);

    logger.t(null);
    expect(printedLevel, Level.trace);
    expect(printedTime, isNotNull);
    expect(printedMessage, null);
    expect(printedError, null);
    expect(printedStackTrace, null);
  });

  test('Roggle.d', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
    final stackTrace = StackTrace.current;
    logger.d('Test', time: time, error: 'Error', stackTrace: stackTrace);
    expect(printedLevel, Level.debug);
    expect(printedTime, time);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);

    logger.d(null);
    expect(printedLevel, Level.debug);
    expect(printedTime, isNotNull);
    expect(printedMessage, null);
    expect(printedError, null);
    expect(printedStackTrace, null);
  });

  test('Roggle.i', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
    final stackTrace = StackTrace.current;
    logger.i('Test', time: time, error: 'Error', stackTrace: stackTrace);
    expect(printedLevel, Level.info);
    expect(printedTime, time);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);

    logger.i(null);
    expect(printedLevel, Level.info);
    expect(printedTime, isNotNull);
    expect(printedMessage, null);
    expect(printedError, null);
    expect(printedStackTrace, null);
  });

  test('Roggle.w', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
    final stackTrace = StackTrace.current;
    logger.w('Test', time: time, error: 'Error', stackTrace: stackTrace);
    expect(printedLevel, Level.warning);
    expect(printedTime, time);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);

    logger.w(null);
    expect(printedLevel, Level.warning);
    expect(printedTime, isNotNull);
    expect(printedMessage, null);
    expect(printedError, null);
    expect(printedStackTrace, null);
  });

  test('Roggle.e', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
    final stackTrace = StackTrace.current;
    logger.e('Test', time: time, error: 'Error', stackTrace: stackTrace);
    expect(printedLevel, Level.error);
    expect(printedTime, time);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);

    logger.e(null);
    expect(printedLevel, Level.error);
    expect(printedTime, isNotNull);
    expect(printedMessage, null);
    expect(printedError, null);
    expect(printedStackTrace, null);
  });

  test('Roggle.wtf', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
    final stackTrace = StackTrace.current;
    logger.wtf('Test', time: time, error: 'Error', stackTrace: stackTrace);
    expect(printedLevel, Level.fatal);
    expect(printedTime, time);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);

    logger.wtf(null);
    expect(printedLevel, Level.fatal);
    expect(printedTime, isNotNull);
    expect(printedMessage, null);
    expect(printedError, null);
    expect(printedStackTrace, null);
  });

  test('Roggle.f', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final time = DateTime.fromMillisecondsSinceEpoch(1684177200000);
    final stackTrace = StackTrace.current;
    logger.f('Test', time: time, error: 'Error', stackTrace: stackTrace);
    expect(printedLevel, Level.fatal);
    expect(printedTime, time);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);

    logger.f(null);
    expect(printedLevel, Level.fatal);
    expect(printedTime, isNotNull);
    expect(printedMessage, null);
    expect(printedError, null);
    expect(printedStackTrace, null);
  });

  test('setting log level above log level of message', () {
    printedMessage = null;
    final logger = Roggle(
      filter: ProductionFilter(),
      printer: callbackPrinter,
      level: Level.warning,
    )..d('This isn\'t logged');
    expect(printedMessage, isNull);

    logger.w('This is');
    expect(printedMessage, 'This is');
  });

  test('setting static log level above log level of message', () {
    printedMessage = null;
    Roggle.level = Level.warning;
    final logger = Roggle(
      filter: ProductionFilter(),
      printer: callbackPrinter,
    )..d('This isn\'t logged');
    expect(printedMessage, isNull);

    logger.w('This is');
    expect(printedMessage, 'This is');

    Roggle.level = Level.trace;
  });

  test('get filter', () {
    final filter = ProductionFilter();
    final logger = Roggle(
      filter: filter,
    );
    expect(logger.filter.hashCode, filter.hashCode);
  });

  test('get printer', () {
    final printer = SinglePrettyPrinter();
    final logger = Roggle(
      printer: printer,
    );
    expect(logger.printer.hashCode, printer.hashCode);
  });

  test('get output', () {
    final output = ConsoleOutput();
    final logger = Roggle(
      output: output,
    );
    expect(logger.output.hashCode, output.hashCode);
  });

  test('isClosed', () {
    final logger = Roggle();
    expect(logger.active, true);
    expect(logger.isClosed(), false);

    logger.close();
    expect(logger.active, false);
    expect(logger.isClosed(), true);
  });

  test('default filter', () {
    var logger = Roggle();
    expect(logger.filter is DevelopmentFilter, true);
    Roggle.defaultFilter = ProductionFilter.new;
    logger = Roggle();
    expect(logger.filter is ProductionFilter, true);
  });

  test('default printer', () {
    var logger = Roggle();
    expect(logger.printer is SinglePrettyPrinter, true);
    Roggle.defaultPrinter = PrettyPrinter.new;
    logger = Roggle();
    expect(logger.printer is PrettyPrinter, true);
  });

  test('default output', () {
    var logger = Roggle();
    expect(logger.output is ConsoleOutput, true);
    Roggle.defaultOutput = StreamOutput.new;
    logger = Roggle();
    expect(logger.output is StreamOutput, true);
  });

  test('logCallback', () {
    LogEvent? receivedEvent;
    void callback(LogEvent event) {
      receivedEvent = event;
    }

    final logger = Roggle();
    Roggle.addLogListener(callback);
    logger.t('Test');
    expect(receivedEvent, isNotNull);

    receivedEvent = null;
    Roggle.removeLogListener(callback);
    logger.t('Test');
    expect(receivedEvent, isNull);
  });

  test('outputCallback', () {
    OutputEvent? receivedEvent;
    void callback(OutputEvent event) {
      receivedEvent = event;
    }

    final logger = Roggle();
    Roggle.addOutputListener(callback);
    logger.t('Test');
    expect(receivedEvent, isNotNull);

    receivedEvent = null;
    Roggle.removeOutputListener(callback);
    logger.t('Test');
    expect(receivedEvent, isNull);
  });
}
