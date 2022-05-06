import '../../roggle.dart';

/// An event of crashlytics error.
class CrashlyticsErrorEvent {
  CrashlyticsErrorEvent(this.level, this.exception, this.stack);

  final Level level;
  final dynamic exception;
  final StackTrace stack;
}

/// An event of crashlytics log.
class CrashlyticsLogEvent {
  CrashlyticsLogEvent(this.level, this.message);

  final Level level;
  final String message;
}

/// [LogPrinter] for crashlytics.
///
/// Calls [onLog] when there is a log message, and calls [onError] when there is
/// an error. Logs above [errorLevel] will be sent as error logs.
/// [CrashlyticsLogEvent.message] of [onLog] looks like this:
/// ```
/// 💡 [INFO]    demo (file:///your/file/path/roggle/example/main.dart:16:10): Log message
/// ```
class CrashlyticsPrinter extends SinglePrettyPrinter {
  CrashlyticsPrinter({
    required this.errorLevel,
    required this.onError,
    this.onLog,
    String? loggerName,
    bool printCaller = true,
    bool printEmojis = true,
    bool printLabels = true,
    Map<Level, String> levelEmojis = SinglePrettyPrinter.defaultLevelEmojis,
    Map<Level, String> levelLabels = SinglePrettyPrinter.defaultLevelLabels,
  }) : super(
          loggerName: loggerName,
          colors: false,
          printCaller: printCaller,
          printEmojis: printEmojis,
          printLabels: printLabels,
          printTime: false,
          stackTraceMethodCount: null,
          stackTracePrefix: '',
          levelEmojis: levelEmojis,
          levelLabels: levelLabels,
        );

  /// The current logging level to send error.
  ///
  /// Logs above this level will be sent as error logs.
  final Level errorLevel;

  /// Callback called when an error occurs
  final void Function(CrashlyticsErrorEvent event) onError;

  /// Callback called when printing a log message
  final void Function(CrashlyticsLogEvent event)? onLog;

  @override
  List<String> log(LogEvent event) {
    if (onLog != null) {
      final message = _formatMessage(
        level: event.level,
        message: stringifyMessage(event.message),
      );
      onLog!.call(CrashlyticsLogEvent(event.level, message));
    }

    if (event.level.index >= errorLevel.index) {
      Object error;
      if (event.error != null) {
        // If error is not null, it will be sent with priority.
        error = event.error as Object;
      } else if (event.message is Exception) {
        error = event.message as Exception;
      } else if (event.message is Error) {
        error = event.message as Error;
      } else {
        error = stringifyMessage(event.message);
      }

      List<String> stackTraceLines;
      if (event.stackTrace != null) {
        // If stackTrace is not null, it will be sent with priority.
        stackTraceLines = getStackTrace(stackTrace: event.stackTrace);
      } else {
        stackTraceLines = getStackTrace();
      }
      onError.call(
        CrashlyticsErrorEvent(
          event.level,
          error,
          StackTrace.fromString(stackTraceLines.join('\n')),
        ),
      );
    }

    return [];
  }

  String _formatMessage({
    required Level level,
    required String message,
  }) {
    final color = getLevelColor(level);
    final fixed = formatFixed(level: level);
    return color('$fixed$message');
  }
}
