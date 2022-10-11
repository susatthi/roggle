import 'package:stack_trace/stack_trace.dart';

class FrameFactory {
  /// Dart on Mac
  static Frame dartMac() => Frame(
        Uri.parse('file:///Users/dummy/Develop/roggle/example/main.dart'),
        66,
        10,
        'dummy',
      );

  /// Dart on Windows
  static Frame dartWindows() => Frame(
        Uri.parse('file:///C:/Users/dummy/Develop/roggle/example/main.dart'),
        66,
        10,
        'dummy',
      );

  /// Flutter on Web
  static Frame flutterWeb() => Frame(
        Uri.parse(
          'http://localhost:62180/packages/flutter_sample_roggle/main.dart',
        ),
        66,
        10,
        'dummy',
      );

  /// Flutter on Android
  static Frame flutterAndroid() => Frame(
        Uri.parse('package:flutter_sample_roggle/main.dart'),
        66,
        10,
        'dummy',
      );

  /// Flutter on iOS
  static Frame flutterIOS() => Frame(
        Uri.parse('package:flutter_sample_roggle/main.dart'),
        66,
        10,
        'dummy',
      );

  /// Flutter on Mac
  static Frame flutterMac() => Frame(
        Uri.parse('package:flutter_sample_roggle/main.dart'),
        66,
        10,
        'dummy',
      );

  /// Flutter on Windows
  static Frame flutterWindows() => Frame(
        Uri.parse('package:flutter_sample_roggle/main.dart'),
        66,
        10,
        'dummy',
      );
}
