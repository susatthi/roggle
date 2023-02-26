import 'package:roggle/roggle.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:test/test.dart';

void main() {
  Level? printedErrorLevel;
  dynamic printedErrorException;
  StackTrace? printedErrorStack;
  Level? printedLogLevel;
  String? printedLogMessage;

  void onError(CrashlyticsErrorEvent event) {
    printedErrorLevel = event.level;
    printedErrorException = event.exception;
    printedErrorStack = event.stack;
  }

  void onLog(CrashlyticsLogEvent event) {
    printedLogLevel = event.level;
    printedLogMessage = event.message;
  }

  setUp(() {
    printedErrorLevel = null;
    printedErrorException = null;
    printedErrorStack = null;
    printedLogLevel = null;
    printedLogMessage = null;
  });

  group('errorLevel', () {
    test('errorLevel is nothing', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.nothing,
        onError: onError,
        onLog: onLog,
      );

      final levels = Level.values.take(6);
      for (final level in levels) {
        final event = LogEvent(
          level,
          '',
        );
        printer.log(event);
        expect(printedLogLevel, level);
        expect(printedLogMessage, isNotNull);
        switch (level) {
          case Level.verbose:
          case Level.debug:
          case Level.info:
          case Level.warning:
          case Level.error:
          case Level.wtf:
            expect(printedErrorLevel, isNull);
            expect(printedErrorException, isNull);
            expect(printedErrorStack, isNull);
            break;
          case Level.nothing:
            // not reachable
            break;
        }
      }
    });
    test('errorLevel is verbose', () {
      const expectedMessage = 'some message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.verbose,
        onError: onError,
        onLog: onLog,
      );

      final levels = Level.values.take(6);
      for (final level in levels) {
        final event = LogEvent(
          level,
          expectedMessage,
        );
        printer.log(event);
        expect(printedLogLevel, level);
        expect(printedLogMessage, isNotNull);
        switch (level) {
          case Level.verbose:
          case Level.debug:
          case Level.info:
          case Level.warning:
          case Level.error:
          case Level.wtf:
            expect(printedErrorLevel, level);
            expect(printedErrorException, expectedMessage);
            expect(printedErrorStack, isNotNull);
            break;
          case Level.nothing:
            // not reachable
            break;
        }
      }
    });
    test('errorLevel is debug', () {
      const expectedMessage = 'some message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.debug,
        onError: onError,
        onLog: onLog,
      );

      final levels = Level.values.take(6);
      for (final level in levels) {
        final event = LogEvent(
          level,
          expectedMessage,
        );
        printer.log(event);
        expect(printedLogLevel, level);
        expect(printedLogMessage, isNotNull);
        switch (level) {
          case Level.verbose:
            expect(printedErrorLevel, isNull);
            expect(printedErrorException, isNull);
            expect(printedErrorStack, isNull);
            break;
          case Level.debug:
          case Level.info:
          case Level.warning:
          case Level.error:
          case Level.wtf:
            expect(printedErrorLevel, level);
            expect(printedErrorException, expectedMessage);
            expect(printedErrorStack, isNotNull);
            break;
          case Level.nothing:
            // not reachable
            break;
        }
      }
    });
    test('errorLevel is info', () {
      const expectedMessage = 'some message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.info,
        onError: onError,
        onLog: onLog,
      );

      final levels = Level.values.take(6);
      for (final level in levels) {
        final event = LogEvent(
          level,
          expectedMessage,
        );
        printer.log(event);
        expect(printedLogLevel, level);
        expect(printedLogMessage, isNotNull);
        switch (level) {
          case Level.verbose:
          case Level.debug:
            expect(printedErrorLevel, isNull);
            expect(printedErrorException, isNull);
            expect(printedErrorStack, isNull);
            break;
          case Level.info:
          case Level.warning:
          case Level.error:
          case Level.wtf:
            expect(printedErrorLevel, level);
            expect(printedErrorException, expectedMessage);
            expect(printedErrorStack, isNotNull);
            break;
          case Level.nothing:
            // not reachable
            break;
        }
      }
    });
    test('errorLevel is warning', () {
      const expectedMessage = 'some message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.warning,
        onError: onError,
        onLog: onLog,
      );

      final levels = Level.values.take(6);
      for (final level in levels) {
        final event = LogEvent(
          level,
          expectedMessage,
        );
        printer.log(event);
        expect(printedLogLevel, level);
        expect(printedLogMessage, isNotNull);
        switch (level) {
          case Level.verbose:
          case Level.debug:
          case Level.info:
            expect(printedErrorLevel, isNull);
            expect(printedErrorException, isNull);
            expect(printedErrorStack, isNull);
            break;
          case Level.warning:
          case Level.error:
          case Level.wtf:
            expect(printedErrorLevel, level);
            expect(printedErrorException, expectedMessage);
            expect(printedErrorStack, isNotNull);
            break;
          case Level.nothing:
            // not reachable
            break;
        }
      }
    });
    test('errorLevel is error', () {
      const expectedMessage = 'some message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );

      final levels = Level.values.take(6);
      for (final level in levels) {
        final event = LogEvent(
          level,
          expectedMessage,
        );
        printer.log(event);
        expect(printedLogLevel, level);
        expect(printedLogMessage, isNotNull);
        switch (level) {
          case Level.verbose:
          case Level.debug:
          case Level.info:
          case Level.warning:
            expect(printedErrorLevel, isNull);
            expect(printedErrorException, isNull);
            expect(printedErrorStack, isNull);
            break;
          case Level.error:
          case Level.wtf:
            expect(printedErrorLevel, level);
            expect(printedErrorException, expectedMessage);
            expect(printedErrorStack, isNotNull);
            break;
          case Level.nothing:
            // not reachable
            break;
        }
      }
    });
    test('errorLevel is wtf', () {
      const expectedMessage = 'some message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.wtf,
        onError: onError,
        onLog: onLog,
      );

      final levels = Level.values.take(6);
      for (final level in levels) {
        final event = LogEvent(
          level,
          expectedMessage,
        );
        printer.log(event);
        expect(printedLogLevel, level);
        expect(printedLogMessage, isNotNull);
        switch (level) {
          case Level.verbose:
          case Level.debug:
          case Level.info:
          case Level.warning:
          case Level.error:
            expect(printedErrorLevel, isNull);
            expect(printedErrorException, isNull);
            expect(printedErrorStack, isNull);
            break;
          case Level.wtf:
            expect(printedErrorLevel, level);
            expect(printedErrorException, expectedMessage);
            expect(printedErrorStack, isNotNull);
            break;
          case Level.nothing:
            // not reachable
            break;
        }
      }
    });
  });
  group('onError', () {
    test('error is null and message is String', () {
      const expectedMessage = 'some message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
      );
      final event = LogEvent(
        Level.error,
        expectedMessage,
      );
      printer.log(event);
      expect(printedErrorException, expectedMessage);
    });
    test('error is null and message is Exception', () {
      final expectedMessage = Exception('some exception');
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
      );
      final event = LogEvent(
        Level.error,
        expectedMessage,
      );
      printer.log(event);
      expect(printedErrorException, expectedMessage);
    });
    test('error is null and message is Error', () {
      final expectedMessage = TypeError();
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
      );
      final event = LogEvent(
        Level.error,
        expectedMessage,
      );
      printer.log(event);
      expect(printedErrorException, expectedMessage);
    });
    test('error is null and message is null', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
      );
      final event = LogEvent(
        Level.error,
        null,
      );
      printer.log(event);
      expect(printedErrorException, 'null');
    });
    test('error is exception and message is string', () {
      final expectedError = Exception('some exception');
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
      );
      final event = LogEvent(
        Level.error,
        'some message',
        expectedError,
      );
      printer.log(event);
      expect(printedErrorException, expectedError);
    });
    test('error is exception and message is string', () {
      final expectedError = TypeError();
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
      );
      final event = LogEvent(
        Level.error,
        'some message',
        expectedError,
      );
      printer.log(event);
      expect(printedErrorException, expectedError);
    });
    test('error is string and message is string', () {
      const expectedError = 'some error message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
      );
      final event = LogEvent(
        Level.error,
        'some message',
        expectedError,
      );
      printer.log(event);
      expect(printedErrorException, expectedError);
    });
    test('error is string and message is string and stackTrace is not null',
        () {
      const expectedError = 'some error message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
      );
      final stackTrace = StackTrace.fromString(
        '''
#0      main.<anonymous closure>.<anonymous closure> (file:///Users/dummy/Develop/roggle/test/printers/single_pretty_printer_test.dart:384:24)
#1      Declarer.test.<anonymous closure>.<anonymous closure> (package:test_api/src/backend/declarer.dart:215:19)
#2      Declarer.test.<anonymous closure> (package:test_api/src/backend/declarer.dart:213:7)
#3      Invoker._waitForOutstandingCallbacks.<anonymous closure> (package:test_api/src/backend/invoker.dart:257:7)
''',
      );
      final event = LogEvent(
        Level.error,
        'some message',
        expectedError,
        stackTrace,
      );
      printer.log(event);
      expect(printedErrorException, expectedError);
      expect(printedErrorStack, isNotNull);
      expect(
        printedErrorStack?.toString().contains(
              'main.<fn>.<fn> (/Users/dummy/Develop/roggle/test/printers/single_pretty_printer_test.dart:384:24)',
            ),
        true,
      );
    });
  });
  group('onLog', () {
    test('error is string and message is string', () {
      const expectedError = 'some error message';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      final event = LogEvent(
        Level.error,
        'some message',
        expectedError,
      );
      printer.log(event);
      expect(printedErrorException, expectedError);
    });
  });
  group('loggerName', () {
    test('loggerName is not null', () {
      const loggerName = 'LOGGER_NAME';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
        loggerName: loggerName,
      );
      printer.log(generalEvent);
      expect(printedLogMessage?.contains(loggerName), true);
    });
    test('loggerName is default(null)', () {
      const loggerName = 'LOGGER_NAME';
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      printer.log(generalEvent);
      expect(printedLogMessage?.contains(loggerName), false);
    });
  });
  group('printCaller', () {
    test('printCaller is false', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
        printCaller: false,
      );
      printer.log(generalEvent);
      expect(printedLogMessage?.contains(_getSelfPath()), false);
      expect(printedLogMessage?.contains('main.<fn>.<fn>'), false);
    });
    test('printCaller is default(true)', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      printer.log(generalEvent);
      expect(printedLogMessage?.contains(_getSelfPath()), true);
      expect(printedLogMessage?.contains('main.<fn>.<fn>'), true);
    });
  });
  group('printFunctionName', () {
    test('printFunctionName is false', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
        printFunctionName: false,
      );
      printer.log(generalEvent);
      expect(printedLogMessage?.contains(_getSelfPath()), true);
      expect(printedLogMessage?.contains('main.<fn>.<fn>'), false);
    });
    test('printFunctionName is default(true)', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      printer.log(generalEvent);
      expect(printedLogMessage?.contains(_getSelfPath()), true);
      expect(printedLogMessage?.contains('main.<fn>.<fn>'), true);
    });
  });
  group('printLocation', () {
    test('printLocation is false', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
        printLocation: false,
      );
      printer.log(generalEvent);
      expect(printedLogMessage?.contains(_getSelfPath()), false);
      expect(printedLogMessage?.contains('main.<fn>.<fn>'), true);
    });
    test('printLocation is default(true)', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      printer.log(generalEvent);
      expect(printedLogMessage?.contains(_getSelfPath()), true);
      expect(printedLogMessage?.contains('main.<fn>.<fn>'), true);
    });
  });
  group('printEmojis', () {
    test('printEmojis is false', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
        printEmojis: false,
      );
      printer.log(generalEvent);
      expect(
        printedLogMessage?.contains(
          SinglePrettyPrinter.defaultLevelEmojis[Level.error]!,
        ),
        false,
      );
    });
    test('printEmojis is default(true)', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      printer.log(generalEvent);
      expect(
        printedLogMessage?.contains(
          SinglePrettyPrinter.defaultLevelEmojis[Level.error]!,
        ),
        true,
      );
    });
  });
  group('printLabels', () {
    test('printLabels is false', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
        printLabels: false,
      );
      printer.log(generalEvent);
      expect(
        printedLogMessage?.contains(
          SinglePrettyPrinter.defaultLevelLabels[Level.error]!,
        ),
        false,
      );
    });
    test('printLabels is default(true)', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      printer.log(generalEvent);
      expect(
        printedLogMessage?.contains(
          SinglePrettyPrinter.defaultLevelLabels[Level.error]!,
        ),
        true,
      );
    });
  });
  group('levelEmojis', () {
    test('levelEmojis is specified', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
        levelEmojis: {
          ...SinglePrettyPrinter.defaultLevelEmojis,
          Level.error: '😅',
        },
      );
      printer.log(generalEvent);
      expect(
        printedLogMessage?.contains('😅'),
        true,
      );
      expect(
        printedLogMessage?.contains(
          SinglePrettyPrinter.defaultLevelEmojis[Level.error]!,
        ),
        false,
      );
    });
    test('levelEmojis is not specified', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      printer.log(generalEvent);
      expect(
        printedLogMessage?.contains('😅'),
        false,
      );
      expect(
        printedLogMessage?.contains(
          SinglePrettyPrinter.defaultLevelEmojis[Level.error]!,
        ),
        true,
      );
    });
  });
  group('levelLabels', () {
    test('levelLabels is specified', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
        levelLabels: {
          ...SinglePrettyPrinter.defaultLevelLabels,
          Level.error: '[error]',
        },
      );
      printer.log(generalEvent);
      expect(
        printedLogMessage?.contains('[error]'),
        true,
      );
      expect(
        printedLogMessage?.contains(
          SinglePrettyPrinter.defaultLevelLabels[Level.error]!,
        ),
        false,
      );
    });
    test('levelLabels is not specified', () {
      final printer = CrashlyticsPrinter(
        errorLevel: Level.error,
        onError: onError,
        onLog: onLog,
      );
      printer.log(generalEvent);
      expect(
        printedLogMessage?.contains('[error]'),
        false,
      );
      expect(
        printedLogMessage?.contains(
          SinglePrettyPrinter.defaultLevelLabels[Level.error]!,
        ),
        true,
      );
    });
  });
}

String _getSelfPath() {
  final match = RegExp(r'^(.+.dart)')
      .firstMatch(Frame.caller(0).toString().replaceAll('\\', '/'));
  if (match == null) {
    return '';
  }
  return match.group(1)!;
}

LogEvent get generalEvent => LogEvent(
      Level.error,
      'some message',
    );
