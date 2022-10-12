# Roggle

<a href="https://github.com/susatthi/roggle/actions/workflows/test.yaml"><img src="https://github.com/susatthi/roggle/actions/workflows/test.yaml/badge.svg" alt="Test"></a>
<a href="https://codecov.io/gh/susatthi/roggle"><img src="https://codecov.io/gh/susatthi/roggle/branch/main/graph/badge.svg?token=32O6RLP872" alt="codecov"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-purple" alt="MIT"></a>

Simple, colorful and easy to expand logger for dart.<br>
Inspired by [the logger](https://pub.dev/packages/logger) and dependent to the logger.

## Getting Started

Just create an instance of `Roggle` and start logging:

```dart
import 'package:roggle/roggle.dart';

final logger = Roggle();

logger.d('Roggle is working!');
```

Instead of a string message, you can also pass other objects like `List`, `Map`, `Set` or `Function`.

## Output

![androidstudio](https://user-images.githubusercontent.com/13707135/195221622-341dbf2d-5708-441b-a804-5eae969855d6.png)

# Documentation

Roggle's API is almost the same as the logger. See [the logger](https://pub.dev/packages/logger) for basic usage.

## Difference from the logger

- Printer defaults to `SinglePrettyPrinter` class.
- Not try-catch at `LogOutput` class, because we want to stop the process.
- Added some getters in `Roggle` class.
- Changed the log interface `dynamic` to `Object?`.

## Options

If you use the `SinglePrettyPrinter`, there are more options:

```dart
final logger = Roggle(
  printer: SinglePrettyPrinter(
    loggerName: '[APP]', // Print a logger name for each log message
    colors: true, // Colorful log messages
    printCaller: true, // Print a caller for each log message
    printLocation: true, // Print a location of caller for each log message
    printFunctionName: true, // Print a function name of caller for each log message
    printEmojis: true, // Print an emoji for each log message
    printLabels: true, // Print a level string for each log message
    printTime: true, // Print a timestamp for each log message
    stackTraceLevel:
        Level.error, // The current logging level to display stack trace
    stackTraceMethodCount: 10, // Number of stack trace methods to display
    stackTracePrefix: '>>> ', // Replace stack trace prefix
    levelColors: {}, // Replace level colors map
    levelEmojis: {}, // Replace level emojis map
    levelLabels: {}, // Replace level labels map
    timeFormatter: (now) => DateFormat('yyyy/MM/dd HH:mm:ss.SSS')
        .format(now), // Replace time formatter
  ),
);
```

![SinglePrettyPrinter](https://user-images.githubusercontent.com/13707135/195223339-4837870f-cfcd-4447-b0b1-f958531a6db0.png)

You can use the `Roggle.crashlytics()` to send errors and logs using the `FirebaseCrashlytics` API in release mode.

```dart
final logger = Roggle.crashlytics(
  printer: CrashlyticsPrinter(
    errorLevel: Level.error, // Logs above this level will call onError
    onError: (event) {
      // Send an error to Firebase Crashlytics as follows
      FirebaseCrashlytics.instance.recordError(
        event.exception,
        event.stack,
        fatal: true,
      );
    },
    onLog: (event) {
      // Send logs to Firebase Crashlytics as follows
      FirebaseCrashlytics.instance.log(event.message);
    },
    loggerName: '[APP]',
    printCaller: true, // Print a caller for each log message
    printLocation: true, // Print a location of caller for each log message
    printFunctionName: true, // Print a function name of caller for each log message
    printEmojis: true, // Print an emoji for each log message
    printLabels: true, // Print a level string for each log message
    levelEmojis: {}, // Replace level emojis map
    levelLabels: {}, // Replace level labels map
  ),
);
```

## Tips

If you want to stop the process at the same time as the error log, do the following.

```dart
import 'package:roggle/roggle.dart';

final logger = Roggle(
  output: AssertionOutput(),
);

class AssertionOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    super.output(event);
    if (event.level.index >= Level.error.index) {
      throw AssertionError('Stopped by logger.');
    }
  }
}
```

## License

```
MIT License

Copyright (c) 2022 Keyber Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
