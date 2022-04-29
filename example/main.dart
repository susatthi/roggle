import 'package:roggle/roggle.dart';

final logger = Roggle(
  printer: SinglePrettyPrinter(
    loggerName: '[APP]',
    stackTraceLevel: Level.error,
  ),
);

void main() {
  print(
      'Run with either `dart example/main.dart` or `dart --enable-asserts example/main.dart`.');
  demo();
}

void demo() {
  logger.d('Log message with 2 methods');

  logger.e('Error! Something bad happened', 'Test Error');

  logger.i('Log message');
}
