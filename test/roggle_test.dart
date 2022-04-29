import 'dart:math';

import 'package:roggle/roggle.dart';
import 'package:test/test.dart';

typedef PrinterCallback = List<String> Function(
  Level level,
  dynamic message,
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
      event.error,
      event.stackTrace,
    );
  }
}

void main() {
  Level? printedLevel;
  dynamic printedMessage;
  dynamic printedError;
  StackTrace? printedStackTrace;
  final callbackPrinter = _CallbackPrinter((l, dynamic m, dynamic e, s) {
    printedLevel = l;
    printedMessage = m;
    printedError = e;
    printedStackTrace = s;
    return [];
  });

  setUp(() {
    printedLevel = null;
    printedMessage = null;
    printedError = null;
    printedStackTrace = null;
  });

  test('Roggle.log', () {
    var logger = Roggle(filter: _NeverFilter(), printer: callbackPrinter)
      ..log(Level.debug, 'Some message');

    expect(printedMessage, null);

    logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);

    final levels = Level.values.take(6);
    for (final level in levels) {
      var message = Random().nextInt(999999999).toString();
      logger.log(level, message);
      expect(printedLevel, level);
      expect(printedMessage, message);
      expect(printedError, null);
      expect(printedStackTrace, null);

      message = Random().nextInt(999999999).toString();
      logger.log(level, message, 'MyError');
      expect(printedLevel, level);
      expect(printedMessage, message);
      expect(printedError, 'MyError');
      expect(printedStackTrace, null);

      message = Random().nextInt(999999999).toString();
      final stackTrace = StackTrace.current;
      logger.log(level, message, 'MyError', stackTrace);
      expect(printedLevel, level);
      expect(printedMessage, message);
      expect(printedError, 'MyError');
      expect(printedStackTrace, stackTrace);
    }

    expect(
      () => logger.log(Level.verbose, 'Test', StackTrace.current),
      throwsArgumentError,
    );
    expect(() => logger.log(Level.nothing, 'Test'), throwsArgumentError);
  });

  test('Roggle.v', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final stackTrace = StackTrace.current;
    logger.v('Test', 'Error', stackTrace);
    expect(printedLevel, Level.verbose);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);
  });

  test('Roggle.d', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final stackTrace = StackTrace.current;
    logger.d('Test', 'Error', stackTrace);
    expect(printedLevel, Level.debug);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);
  });

  test('Roggle.i', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final stackTrace = StackTrace.current;
    logger.i('Test', 'Error', stackTrace);
    expect(printedLevel, Level.info);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);
  });

  test('Roggle.w', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final stackTrace = StackTrace.current;
    logger.w('Test', 'Error', stackTrace);
    expect(printedLevel, Level.warning);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);
  });

  test('Roggle.e', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final stackTrace = StackTrace.current;
    logger.e('Test', 'Error', stackTrace);
    expect(printedLevel, Level.error);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);
  });

  test('Roggle.wtf', () {
    final logger = Roggle(filter: _AlwaysFilter(), printer: callbackPrinter);
    final stackTrace = StackTrace.current;
    logger.wtf('Test', 'Error', stackTrace);
    expect(printedLevel, Level.wtf);
    expect(printedMessage, 'Test');
    expect(printedError, 'Error');
    expect(printedStackTrace, stackTrace);
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
}
