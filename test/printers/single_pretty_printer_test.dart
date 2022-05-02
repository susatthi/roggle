import 'package:roggle/roggle.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:test/test.dart';

void main() {
  group('loggerName', () {
    test('loggerName is not null', () {
      const loggerName = 'LOGGER_NAME';
      final printer = SinglePrettyPrinter(loggerName: loggerName);
      _wrapPropertyTest(printer, loggerName, true);
    });
    test('loggerName is default(null)', () {
      const loggerName = 'LOGGER_NAME';
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(printer, loggerName, false);
    });
  });
  group('colors', () {
    test('colors is false', () {
      final printer = SinglePrettyPrinter(colors: false);
      _wrapPropertyTest(printer, AnsiColor.ansiEsc, false);
    });
    test('colors is default(true)', () {
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(printer, AnsiColor.ansiEsc, true);
    });
  });
  group('printCaller', () {
    test('printCaller is false', () {
      final printer = SinglePrettyPrinter(printCaller: false);
      _wrapPropertyTest(printer, _getSelfPath(), false);
    });
    test('printCaller is default(true)', () {
      final printer = SinglePrettyPrinter();
      // _wrapPropertyTest(printer, _getSelfPath(), true);

      final frame = Frame.caller(0).toString();
      // ignore: avoid_print
      print(frame);

      final match = RegExp(r'^(.+.dart)').firstMatch(frame);
      final pattern = match == null ? '' : match.group(1)!;
      const expectContain = true;
      const expectedMessage = 'some message';
      final event = LogEvent(
        Level.info,
        expectedMessage,
        null,
        null,
      );

      final actualLogString = _readMessage(printer.log(event));
      // ignore: avoid_print
      print(actualLogString);
      // ignore: avoid_print
      print(pattern);
      expect(actualLogString.contains(pattern), expectContain);
      expect(actualLogString.contains(expectedMessage), true);
    });
  });
  group('printEmojis', () {
    test('printEmojis is false', () {
      final printer = SinglePrettyPrinter(printEmojis: false);
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelEmojis[Level.info]!,
        false,
      );
    });
    test('printEmojis is default(true)', () {
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelEmojis[Level.info]!,
        true,
      );
    });
  });
  group('printLabels', () {
    test('printLabels is false', () {
      final printer = SinglePrettyPrinter(printLabels: false);
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelLabels[Level.info]!,
        false,
      );
    });
    test('printLabels is default(true)', () {
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelLabels[Level.info]!,
        true,
      );
    });
  });
  group('printTime', () {
    test('printTime is false', () {
      final printer = SinglePrettyPrinter(printTime: false);
      _wrapPropertyTest(printer, RegExp(r'\d{2}:\d{2}:\d{2}.\d{3}'), false);
    });
    test('printTime is default(true)', () {
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(printer, RegExp(r'\d{2}:\d{2}:\d{2}.\d{3}'), true);
    });
  });
  group('stackTraceLevel', () {
    test('stackTraceLevel is Level.info', () {
      final printer = SinglePrettyPrinter(stackTraceLevel: Level.warning);
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        false,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #1',
        false,
      );
    });
    test('stackTraceLevel is Level.info', () {
      final printer = SinglePrettyPrinter(stackTraceLevel: Level.info);
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        true,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #1',
        true,
      );
    });
    test('stackTraceLevel is default(Level.nothing)', () {
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        false,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #1',
        false,
      );
    });
  });
  group('stackTraceMethodCount', () {
    test('stackTraceMethodCount is 0', () {
      final printer = SinglePrettyPrinter(
        stackTraceLevel: Level.info,
        stackTraceMethodCount: 0,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        false,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #1',
        false,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #2',
        false,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #3',
        false,
      );
    });
    test('stackTraceMethodCount is 1', () {
      final printer = SinglePrettyPrinter(
        stackTraceLevel: Level.info,
        stackTraceMethodCount: 1,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        true,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #1',
        false,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #2',
        false,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #3',
        false,
      );
    });
    test('stackTraceMethodCount is 2', () {
      final printer = SinglePrettyPrinter(
        stackTraceLevel: Level.info,
        stackTraceMethodCount: 2,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        true,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #1',
        true,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #2',
        false,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #3',
        false,
      );
    });
    test('stackTraceMethodCount is 3', () {
      final printer = SinglePrettyPrinter(
        stackTraceLevel: Level.info,
        stackTraceMethodCount: 3,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        true,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #1',
        true,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #2',
        true,
      );
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #3',
        false,
      );
    });
  });
  group('stackTracePrefix', () {
    test('stackTracePrefix is >>>', () {
      final printer = SinglePrettyPrinter(
        stackTraceLevel: Level.info,
        stackTracePrefix: '>>>',
      );
      _wrapPropertyTest(printer, '>>> #0', true);
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        false,
      );
    });
    test('stackTracePrefix is default', () {
      final printer = SinglePrettyPrinter(
        stackTraceLevel: Level.info,
      );
      _wrapPropertyTest(printer, '>>> #0', false);
      _wrapPropertyTest(
        printer,
        '${SinglePrettyPrinter.defaultStackTracePrefix} #0',
        true,
      );
    });
  });
  group('levelColors', () {
    test('levelColors is specified', () {
      final printer = SinglePrettyPrinter(
        levelColors: {
          ...SinglePrettyPrinter.defaultLevelColors,
          Level.info: AnsiColor.none(),
        },
      );
      _wrapPropertyTest(printer, AnsiColor.ansiEsc, false);
    });
    test('levelColors is not specified', () {
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(printer, AnsiColor.ansiEsc, true);
    });
  });
  group('levelEmojis', () {
    test('levelEmojis is specified', () {
      final printer = SinglePrettyPrinter(
        levelEmojis: {
          ...SinglePrettyPrinter.defaultLevelEmojis,
          Level.info: '😅',
        },
      );
      _wrapPropertyTest(printer, '😅', true);
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelEmojis[Level.info]!,
        false,
      );
    });
    test('levelEmojis is not specified', () {
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(printer, '😅', false);
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelEmojis[Level.info]!,
        true,
      );
    });
  });
  group('levelLabels', () {
    test('levelLabels is specified', () {
      final printer = SinglePrettyPrinter(
        levelLabels: {
          ...SinglePrettyPrinter.defaultLevelLabels,
          Level.info: '[info]',
        },
      );
      _wrapPropertyTest(printer, '[info]', true);
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelLabels[Level.info]!,
        false,
      );
    });
    test('levelLabels is not specified', () {
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(printer, '[info]', false);
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelLabels[Level.info]!,
        true,
      );
    });
  });
  group('timeFormatter', () {
    test('timeFormatter is specified', () {
      const expectedText = 'expectedText';
      final printer = SinglePrettyPrinter(
        timeFormatter: (now) {
          return expectedText;
        },
      );
      _wrapPropertyTest(printer, expectedText, true);
    });
    test('timeFormatter is not specified', () {
      const expectedText = 'expectedText';
      final printer = SinglePrettyPrinter();
      _wrapPropertyTest(printer, expectedText, false);
    });
  });
  group('any properties is specified', () {
    test('very simple', () {
      final printer = SinglePrettyPrinter(
        colors: false,
        printCaller: false,
        printEmojis: false,
        printLabels: false,
        printTime: false,
      );
      _wrapPropertyTest(printer, AnsiColor.ansiEsc, false);
      _wrapPropertyTest(printer, _getSelfPath(), false);
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelEmojis[Level.info]!,
        false,
      );
      _wrapPropertyTest(
        printer,
        SinglePrettyPrinter.defaultLevelLabels[Level.info]!,
        false,
      );
      _wrapPropertyTest(printer, RegExp(r'\d{2}:\d{2}:\d{2}.\d{3}'), false);
    });
  });
  group('log()', () {
    test('event.message is null', () {
      final printer = SinglePrettyPrinter();
      final event = LogEvent(
        Level.info,
        null,
        null,
        null,
      );
      final actualLogString = _readMessage(printer.log(event));
      expect(actualLogString.contains('null'), true);
    });
    test('event.message is function', () {
      final printer = SinglePrettyPrinter();
      final event = LogEvent(
        Level.info,
        () => 'function message',
        null,
        null,
      );
      final actualLogString = _readMessage(printer.log(event));
      expect(actualLogString.contains('function message'), true);
    });
    test('event.error is not null', () {
      const expectedMessage = 'some message';
      final expectedError = Exception('some exception');
      final printer = SinglePrettyPrinter();
      final event = LogEvent(
        Level.info,
        expectedMessage,
        expectedError,
        null,
      );
      final actualLogString = _readMessage(printer.log(event));
      expect(actualLogString.contains(expectedMessage), true);
      expect(actualLogString.contains(expectedError.toString()), true);
    });
    test('event.stackTrace is not null', () {
      const expectedMessage = 'some message';
      final stackTrace = StackTrace.fromString(
        '''
#0      main.<anonymous closure>.<anonymous closure> (file:///Users/susa/Develop/roggle/test/printers/single_pretty_printer_test.dart:384:24)
#1      Declarer.test.<anonymous closure>.<anonymous closure> (package:test_api/src/backend/declarer.dart:215:19)
#2      Declarer.test.<anonymous closure> (package:test_api/src/backend/declarer.dart:213:7)
#3      Invoker._waitForOutstandingCallbacks.<anonymous closure> (package:test_api/src/backend/invoker.dart:257:7)
''',
      );
      final printer = SinglePrettyPrinter();
      final event = LogEvent(
        Level.info,
        expectedMessage,
        null,
        stackTrace,
      );
      final actualLogString = _readMessage(printer.log(event));
      expect(actualLogString.contains(expectedMessage), true);
      expect(
        actualLogString.contains(
          'main.<anonymous closure>.<anonymous closure> (file:///Users/susa/Develop/roggle/test/printers/single_pretty_printer_test.dart:384:24)',
        ),
        true,
      );
    });
    test('event.error is not null and event.stackTrace is not null', () {
      const expectedMessage = 'some message';
      final expectedError = Exception('some exception');
      final stackTrace = StackTrace.fromString(
        '''
#0      main.<anonymous closure>.<anonymous closure> (file:///Users/susa/Develop/roggle/test/printers/single_pretty_printer_test.dart:384:24)
#1      Declarer.test.<anonymous closure>.<anonymous closure> (package:test_api/src/backend/declarer.dart:215:19)
#2      Declarer.test.<anonymous closure> (package:test_api/src/backend/declarer.dart:213:7)
#3      Invoker._waitForOutstandingCallbacks.<anonymous closure> (package:test_api/src/backend/invoker.dart:257:7)
''',
      );
      final printer = SinglePrettyPrinter();
      final event = LogEvent(
        Level.info,
        expectedMessage,
        expectedError,
        stackTrace,
      );
      final actualLogString = _readMessage(printer.log(event));
      expect(actualLogString.contains(expectedMessage), true);
      expect(actualLogString.contains(expectedError.toString()), true);
      expect(
        actualLogString.contains(
          'main.<anonymous closure>.<anonymous closure> (file:///Users/susa/Develop/roggle/test/printers/single_pretty_printer_test.dart:384:24)',
        ),
        true,
      );
    });
  });
  group('discardDeviceStackTraceLine()', () {
    test('discardDeviceStackTraceLine()', () {
      final printer = SinglePrettyPrinter();
      expect(
        printer.discardDeviceStackTraceLine(
          '#0      demo (file:///Users/susa/Develop/roggle/example/main.dart:22:20)',
        ),
        false,
      );
      expect(
        printer.discardDeviceStackTraceLine(
          '#0      _MyHomePageState._incrementCounter (package:flutter_sample_custom_logger/main.dart:51:22)',
        ),
        false,
      );
      expect(
        printer.discardDeviceStackTraceLine(
          '#1      Roggle.log (package:roggle/src/roggle.dart:90:31)',
        ),
        true,
      );
      expect(
        printer.discardDeviceStackTraceLine(
          '#2      Roggle.v (package:roggle/src/roggle.dart:46:5)',
        ),
        true,
      );
      expect(
        printer.discardDeviceStackTraceLine(
          '#0      SinglePrettyPrinter.log (package:roggle/src/printers/single_pretty_printer.dart:116:22)',
        ),
        true,
      );
    });
  });
  group('discardWebStackTraceLine()', () {
    test('discardWebStackTraceLine()', () {
      final printer = SinglePrettyPrinter();
      expect(
        printer.discardWebStackTraceLine(
          '#0      demo (file:///Users/susa/Develop/roggle/example/main.dart:22:20)',
        ),
        false,
      );
      expect(
        printer.discardWebStackTraceLine(
          'dart-sdk/lib/_internal/js_dev_runtime/patch/core_patch.dart 910:28   get current',
        ),
        true,
      );
      expect(
        printer.discardWebStackTraceLine(
          'packages/flutter_sample_custom_logger/logger.dart 116:22             log',
        ),
        false,
      );
      expect(
        printer.discardWebStackTraceLine(
          'packages/roggle/src/roggle.dart 90:31                                log',
        ),
        true,
      );
      expect(
        printer.discardWebStackTraceLine(
          'packages/roggle/src/roggle.dart 46:5                                 v',
        ),
        true,
      );
      expect(
        printer.discardWebStackTraceLine(
          'packages/flutter_sample_custom_logger/main.dart 5:10                 main\$',
        ),
        false,
      );
      expect(
        printer.discardWebStackTraceLine(
          'packages/roggle/src/roggle.dart 90:31 package:roggle/src/printers/single_pretty_printer.dart',
        ),
        true,
      );
    });
  });

  group('getCaller()', () {
    test('device', () {
      _wrapCallerTest(
        '#0      demo (file:///Users/susa/Develop/roggle/example/main.dart:22:20)',
        'demo (file:///Users/susa/Develop/roggle/example/main.dart:22:20)',
      );
      _wrapCallerTest(
        '#0      _MyHomePageState._incrementCounter (package:flutter_sample_custom_logger/main.dart:51:22)',
        '_MyHomePageState._incrementCounter (/main.dart:51:22)',
      );
      _wrapCallerTest(
        '''
#0      SinglePrettyPrinter.log (package:roggle/src/printers/single_pretty_printer.dart:116:22)
#1      Roggle.log (package:roggle/src/roggle.dart:90:31)
#2      Roggle.v (package:roggle/src/roggle.dart:46:5)
#3      main (package:flutter_sample_custom_logger/main.dart:5:10)
#4      _runMainZoned.<anonymous closure>.<anonymous closure> (dart:ui/hooks.dart:130:25)
        ''',
        'main (/main.dart:5:10)',
      );
    });
    test('web', () {
      _wrapCallerTest(
        '''
dart:/lib/_internal/js_dev_runtime/patch/core_patch.dart 910:28   get current
packages/flutter_sample_custom_logger/logger.dart 116:11             log
packages/roggle/src/roggle.dart 90:31                                log
packages/roggle/src/roggle.dart 46:5                                 v
packages/flutter_sample_custom_logger/main.dart 5:10                 main
        ''',
        '/logger.dart 116:11             log',
      );
    });
  });
  group('formatTime()', () {
    test('formatTime()', () {
      _wrapCurrentTimeTest(
        DateTime(2022),
        '00:00:00.000',
      );
      _wrapCurrentTimeTest(
        DateTime(2022, 1, 1, 10, 10, 10, 10),
        '10:10:10.010',
      );
      _wrapCurrentTimeTest(
        DateTime(2022, 1, 1, 20, 20, 20, 100),
        '20:20:20.100',
      );
    });
  });
}

String _readMessage(List<String> log) {
  return log.reduce((acc, val) => acc + val);
}

String _getSelfPath() {
  final match = RegExp(r'^(.+.dart)').firstMatch(Frame.caller(0).toString());
  if (match == null) {
    return '';
  }
  return match.group(1)!;
}

void _wrapPropertyTest(
  SinglePrettyPrinter printer,
  Pattern pattern,
  bool expectContain,
) {
  const expectedMessage = 'some message';
  final event = LogEvent(
    Level.info,
    expectedMessage,
    null,
    null,
  );

  final actualLogString = _readMessage(printer.log(event));
  expect(actualLogString.contains(pattern), expectContain);
  expect(actualLogString.contains(expectedMessage), true);
}

void _wrapCallerTest(
  String stackTraceString,
  String? expectCaller,
) {
  final printer = SinglePrettyPrinter();
  final actualCaller = printer.getCaller(
    stackTrace: StackTrace.fromString(stackTraceString),
  );
  expect(actualCaller, expectCaller);
}

void _wrapCurrentTimeTest(
  DateTime dateTime,
  String? expectTime,
) {
  final actualTime = SinglePrettyPrinter.formatTime(dateTime);
  expect(actualTime, expectTime);
}
