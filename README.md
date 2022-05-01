# Roggle

<a href="https://github.com/susatthi/roggle/actions/workflows/test.yaml"><img src="https://github.com/susatthi/roggle/actions/workflows/test.yaml/badge.svg" alt="Test"></a>
<a href="https://codecov.io/gh/susatthi/roggle"><img src="https://codecov.io/gh/susatthi/roggle/branch/main/graph/badge.svg?token=32O6RLP872" alt="codecov"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-purple" alt="MIT"></a>

Simple, colorful and easy to expand logger for dart.<br>
Inspired by [logger](https://pub.dev/packages/logger).

## Getting Started

Just create an instance of `Roggle` and start logging:

```dart
final logger = Roggle();

logger.d('Roggle is working!');
```

Instead of a string message, you can also pass other objects like `List`, `Map`, `Set` or `Function`.

## Output

![Roggle](https://user-images.githubusercontent.com/13707135/166134905-402bb9d1-5154-42d0-b23b-4b6c658d2452.png)

# Documentation

Roggle's API is almost the same as logger. See [logger](https://pub.dev/packages/logger) for basic usage.

## Options

If you use the `SinglePrettyPrinter`, there are more options:

```dart
final logger = Roggle(
  printer: SinglePrettyPrinter(
    loggerName: '[APP]', // Print a logger name for each log message
    colors: true, // Colorful log messages
    printCaller: true, // Print a caller for each log message
    printEmojis: true, // Print an emoji for each log message
    printLabels: true, // Print a level string for each log message
    printTime: true, // Print a timestamp for each log message
    stackTraceLevel: Level.error, // The current logging level to display stack trace
    stackTraceMethodCount: 10, // Number of stack trace methods to display
  ),
);
```

![SinglePrettyPrinter](https://user-images.githubusercontent.com/13707135/166135290-106a8f26-6ea3-4ecc-90ce-9f33712d3641.png)

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

## MIT License
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
