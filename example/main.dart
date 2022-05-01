import 'package:roggle/roggle.dart';

final logger = Roggle(
  printer: SinglePrettyPrinter(
    loggerName: '[APP]',
    stackTraceLevel: Level.error,
  ),
);

void main() {
  // ignore: avoid_print
  print(
    'Run with either `dart example/main.dart` or `dart --enable-asserts example/main.dart`.',
  );
  demo();
}

void demo() {
  logger.v('Hello roggle!');
  logger.d(1000);
  logger.i(true);
  logger.w([1, 2, 3]);
  logger.e({'key': 'key', 'value': 'value'});
  logger.wtf(Exception('some exception'));
  logger.i(() => 'function message');

  try {
    throw Exception('some exception');
  } on Exception catch (e, s) {
    logger.w('with Exception', e, s);
  }
}
