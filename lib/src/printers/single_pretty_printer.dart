import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart';

/// Default implementation of [LogPrinter].
///
/// Output looks like this:
/// ```
/// 💡 [INFO]    06:46:15.354 demo (file:///your/file/path/roggle/example/main.dart:16:10): Log message
/// ```
class SinglePrettyPrinter extends LogPrinter {
  SinglePrettyPrinter({
    this.loggerName,
    this.colors = true,
    this.printCaller = true,
    this.printEmojis = true,
    this.printLabels = true,
    this.printTime = true,
    this.stackTraceLevel = Level.nothing,
    this.stackTraceMethodCount = defaultStackTraceMethodCount,
    this.stackTracePrefix = defaultStackTracePrefix,
    Map<Level, AnsiColor>? levelColors,
    this.levelEmojis = defaultLevelEmojis,
    this.levelLabels = defaultLevelLabels,
    this.timeFormatter = formatTime,
  }) : _levelColors = levelColors ?? defaultLevelColors;

  /// If specified, it will be output at the beginning of the log.
  final String? loggerName;

  /// If set to true, the log will be colorful.
  final bool colors;

  /// If set to true, caller will be output to the log.
  final bool printCaller;

  /// If set to true, the emoji will be output to the log.
  final bool printEmojis;

  /// If set to true, the log level string will be output to the log.
  final bool printLabels;

  /// If set to true, the time stamp will be output to the log.
  final bool printTime;

  /// The current logging level to display stack trace.
  ///
  /// All stack traces with levels below this level will be omitted.
  final Level stackTraceLevel;

  /// Number of stack trace methods to display.
  final int? stackTraceMethodCount;

  /// Stack trace prefix.
  final String stackTracePrefix;

  /// Color for each log level.
  final Map<Level, AnsiColor> _levelColors;

  /// Emoji for each log level.
  final Map<Level, String> levelEmojis;

  /// String for each log level.
  final Map<Level, String> levelLabels;

  /// Formats the current time.
  final TimeFormatter timeFormatter;

  /// Stack trace method count default.
  static const defaultStackTraceMethodCount = 20;

  /// Stack trace prefix default.
  static const defaultStackTracePrefix = '│ ';

  /// Color default for each log level.
  static final defaultLevelColors = {
    Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: AnsiColor.none(),
    Level.info: AnsiColor.fg(12),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.wtf: AnsiColor.fg(199),
  };

  /// Emoji default for each log level.
  static const defaultLevelEmojis = {
    Level.verbose: '🐱',
    Level.debug: '🐛',
    Level.info: '💡',
    Level.warning: '⚠️',
    Level.error: '⛔',
    Level.wtf: '👾',
  };

  /// String default for each log level.
  static const defaultLevelLabels = {
    Level.verbose: '[VERBOSE]',
    Level.debug: '[DEBUG]  ',
    Level.info: '[INFO]   ',
    Level.warning: '[WARNING]',
    Level.error: '[ERROR]  ',
    Level.wtf: '[WTF]    ',
  };

  @override
  List<String> log(LogEvent event) {
    List<String>? stackTraceLines;
    if (event.stackTrace != null) {
      // If stackTrace is not null, it will be displayed with priority.
      stackTraceLines = getStackTrace(stackTrace: event.stackTrace);
    } else if (event.level.index >= stackTraceLevel.index) {
      stackTraceLines = getStackTrace();
    }

    return _formatMessage(
      level: event.level,
      message: stringifyMessage(event.message),
      error: event.error?.toString(),
      stackTrace: stackTraceLines,
    );
  }

  @visibleForTesting
  String? getCaller({
    StackTrace? stackTrace,
  }) {
    final trace = stackTrace != null ? Trace.from(stackTrace) : Trace.current();
    final caller = trace.caller;
    if (caller == null) {
      return null;
    }
    return convertToDescription(caller);
  }

  @protected
  List<String> getStackTrace({
    StackTrace? stackTrace,
  }) {
    final trace = stackTrace != null ? Trace.from(stackTrace) : Trace.current();
    final formatted = <String>[];
    var count = 0;
    for (final frame in trace.frames) {
      if (!frame.isUserFrame) {
        continue;
      }
      if (stackTraceMethodCount != null && count >= stackTraceMethodCount!) {
        break;
      }

      final description = convertToDescription(frame);
      final countPart = count.toString().padRight(7);
      formatted.add('$stackTracePrefix#$countPart$description');
      count++;
    }
    return formatted;
  }

  @protected
  String convertToDescription(Frame frame) {
    final parts = <String>[];
    final member = frame.member;
    if (member != null) {
      parts.add(member);
    }
    parts.add('(${frame.uriLocation})');
    return parts.join(' ');
  }

  @visibleForTesting
  static String formatTime(DateTime now) {
    String threeDigits(int n) {
      if (n >= 100) {
        return '$n';
      }
      if (n >= 10) {
        return '0$n';
      }
      return '00$n';
    }

    String twoDigits(int n) {
      if (n >= 10) {
        return '$n';
      }
      return '0$n';
    }

    final h = twoDigits(now.hour);
    final min = twoDigits(now.minute);
    final sec = twoDigits(now.second);
    final ms = threeDigits(now.millisecond);
    return '$h:$min:$sec.$ms';
  }

  @protected
  String stringifyMessage(dynamic message) {
    if (message is dynamic Function()) {
      return message().toString();
    } else if (message is String) {
      return message;
    }
    return message.toString();
  }

  @protected
  AnsiColor getLevelColor(Level level) {
    if (colors) {
      return _levelColors[level]!;
    } else {
      return AnsiColor.none();
    }
  }

  List<String> _formatMessage({
    required Level level,
    required String message,
    String? error,
    List<String>? stackTrace,
  }) {
    final color = getLevelColor(level);
    final fixed = formatFixed(level: level);
    final logs = <String>[
      color('$fixed$message'),
    ];

    if (error != null) {
      logs.add(color('$fixed$stackTracePrefix $error'));
    }

    if (stackTrace != null && stackTrace.isNotEmpty) {
      for (final line in stackTrace) {
        logs.add(color('$fixed$line'));
      }
    }
    return logs;
  }

  @protected
  String formatFixed({
    required Level level,
  }) {
    final buffer = <String>[];

    if (printEmojis) {
      buffer.add(levelEmojis[level]!);
    }
    if (loggerName != null) {
      buffer.add(loggerName!);
    }
    if (printLabels) {
      buffer.add(levelLabels[level]!);
    }
    if (printTime) {
      buffer.add(timeFormatter(DateTime.now()));
    }
    if (printCaller) {
      final caller = getCaller();
      if (caller != null) {
        buffer.add(caller);
      }
    }
    return buffer.isNotEmpty ? '${buffer.join(' ')}: ' : '';
  }
}

/// Function to format the current time
typedef TimeFormatter = String Function(DateTime now);

extension _TraceHelper on Trace {
  /// Return first frame in user frames
  Frame? get caller {
    for (final frame in frames) {
      if (frame.isUserFrame) {
        return frame;
      }
    }
    return null;
  }
}

extension _FrameHelper on Frame {
  /// If user frame is true, other false
  bool get isUserFrame {
    if (package == 'roggle') {
      return false;
    }
    if (isCore) {
      return false;
    }
    if (isHttp) {
      final paths = uri.path.split('/');
      if (paths.length >= 2 && paths[0] == 'package' && paths[1] == 'roggle') {
        return false;
      }
    }

    return true;
  }

  /// Whether this stack frame comes from the Web.
  bool get isHttp => uri.scheme == 'http' || uri.scheme == 'https';

  /// Uri with line and column
  String get uriLocation {
    if (line == null) {
      return uri.toString();
    }
    if (column == null) {
      return '${uri.toString()}:$line';
    }
    return '${uri.toString()}:$line:$column';
  }
}
