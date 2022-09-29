// ignore_for_file: avoid_print

import 'package:roggle/roggle.dart';

bool get isRelease {
  var isRelease = true;
  assert(
    () {
      isRelease = false;
      return true;
    }(),
  );
  return isRelease;
}

const loggerName = '[APP]';

final logger = isRelease
    ? Roggle.crashlytics(
        printer: CrashlyticsPrinter(
          errorLevel: Level.error,
          onError: (event) {
            // Send an error to Firebase Crashlytics as follows

            // FirebaseCrashlytics.instance.recordError(
            //   event.exception,
            //   event.stack,
            //   fatal: true,
            // );

            print('FirebaseCrashlytics.exception: ${event.exception}');
            event.stack
                .toString()
                .split('\n')
                .where((line) => line.isNotEmpty)
                .forEach((line) {
              print('FirebaseCrashlytics.stack: $line');
            });
          },
          // ignore: unnecessary_lambdas
          onLog: (event) {
            // Send logs to Firebase Crashlytics as follows

            // FirebaseCrashlytics.instance.log(event.message);

            print('FirebaseCrashlytics.log: ${event.message}');
          },
          loggerName: loggerName,
        ),
      )
    : Roggle(
        printer: SinglePrettyPrinter(
          loggerName: loggerName,
          stackTraceLevel: Level.error,
        ),
      );

void main() {
  print(
    'Run with either `dart example/main.dart` or `dart --enable-asserts example/main.dart`.',
  );
  demo();
}

void demo() {
  logger.v('Hello roggle!');
  logger.d(1000);
  logger.i(true);
  logger.i([1, 2, 3]);
  logger.i({'key': 'key', 'value': 'value'});
  logger.i({'apple', 'banana'});
  logger.i(() => 'function message');
  logger.w(Exception('some exception'));
  logger.e(NullThrownError());

  try {
    throw Exception('some exception');
  } on Exception catch (e, s) {
    logger.wtf('wtf...', e, s);
  }
}
