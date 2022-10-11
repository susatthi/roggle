class StackTraceFactory {
  /// Dart on Mac
  static StackTrace dartMac() => StackTrace.fromString('''
#0      SinglePrettyPrinter.getCaller (package:roggle/src/printers/single_pretty_printer.dart:127:26)
#1      SinglePrettyPrinter.formatFixed (package:roggle/src/printers/single_pretty_printer.dart:259:22)
#2      SinglePrettyPrinter._formatMessage (package:roggle/src/printers/single_pretty_printer.dart:223:19)
#3      SinglePrettyPrinter.log (package:roggle/src/printers/single_pretty_printer.dart:115:12)
#4      Roggle.log (package:roggle/src/roggle.dart:104:31)
#5      Roggle.v (package:roggle/src/roggle.dart:60:5)
#6      demo (file:///Users/dummy/Develop/roggle/example/main.dart:66:10)
#7      main (file:///Users/dummy/Develop/roggle/example/main.dart:62:3)
#8      _delayEntrypointInvocation.<anonymous closure> (dart:isolate-patch/isolate_patch.dart:297:19)
#9      _RawReceivePortImpl._handleMessage (dart:isolate-patch/isolate_patch.dart:192:12)
''');

  /// Dart on Windows
  static StackTrace dartWindows() => StackTrace.fromString('''
package:roggle/src/printers/single_pretty_printer.dart 127:21  SinglePrettyPrinter.getCaller
package:roggle/src/printers/single_pretty_printer.dart 260:22  SinglePrettyPrinter.formatFixed
package:roggle/src/printers/single_pretty_printer.dart 224:19  SinglePrettyPrinter._formatMessage
package:roggle/src/printers/single_pretty_printer.dart 115:12  SinglePrettyPrinter.log
package:roggle/src/roggle.dart 104:31                          Roggle.log
package:roggle/src/roggle.dart 60:5                            Roggle.v
example\\main.dart 67:10                                        demo
example\\main.dart 63:3                                         main
dart:isolate-patch/isolate_patch.dart 297:19                   _delayEntrypointInvocation.<fn>
dart:isolate-patch/isolate_patch.dart 192:12                   _RawReceivePortImpl._handleMessage
''');

  /// Flutter on Web
  static StackTrace flutterWeb() => StackTrace.fromString('''
http://localhost:5000/packages/roggle/src/printers/single_pretty_printer.dart 127:26                    getCaller
http://localhost:5000/packages/roggle/src/printers/single_pretty_printer.dart 258:22                    formatFixed
http://localhost:5000/packages/roggle/src/printers/single_pretty_printer.dart 222:19                    [_formatMessage]
http://localhost:5000/packages/roggle/src/printers/single_pretty_printer.dart 115:12                    log
http://localhost:5000/packages/roggle/src/roggle.dart 104:31                                            log
http://localhost:5000/packages/roggle/src/roggle.dart 60:5                                              v
http://localhost:5000/packages/flutter_sample_roggle/main.dart 55:14                                    [_incrementCounter]
http://localhost:5000/packages/flutter/src/material/ink_well.dart 1072:21                               handleTap
http://localhost:5000/packages/flutter/src/gestures/recognizer.dart 253:24                              invokeCallback
http://localhost:5000/packages/flutter/src/gestures/tap.dart 627:11                                     handleTapUp
http://localhost:5000/packages/flutter/src/gestures/tap.dart 306:5                                      [_checkUp]
http://localhost:5000/packages/flutter/src/gestures/tap.dart 276:7                                      acceptGesture
http://localhost:5000/packages/flutter/src/gestures/arena.dart 163:12                                   sweep
http://localhost:5000/packages/flutter/src/gestures/binding.dart 464:20                                 handleEvent
http://localhost:5000/packages/flutter/src/gestures/binding.dart 440:14                                 dispatchEvent
http://localhost:5000/packages/flutter/src/rendering/binding.dart 337:11                                dispatchEvent
http://localhost:5000/packages/flutter/src/gestures/binding.dart 395:7                                  [_handlePointerEventImmediately]
http://localhost:5000/packages/flutter/src/gestures/binding.dart 357:5                                  handlePointerEvent
http://localhost:5000/packages/flutter/src/gestures/binding.dart 314:7                                  [_flushPointerEventQueue]
http://localhost:5000/packages/flutter/src/gestures/binding.dart 295:7                                  [_handlePointerDataPacket]
http://localhost:5000/lib/_engine/engine/platform_dispatcher.dart 1183:13                               invoke1
http://localhost:5000/lib/_engine/engine/platform_dispatcher.dart 244:5                                 invokeOnPointerDataPacket
http://localhost:5000/lib/_engine/engine/pointer_binding.dart 147:39                                    [_onPointerData]
http://localhost:5000/lib/_engine/engine/pointer_binding.dart 653:20                                    <fn>
http://localhost:5000/lib/_engine/engine/pointer_binding.dart 594:14                                    <fn>
http://localhost:5000/lib/_engine/engine/pointer_binding.dart 288:16                                    loggedHandler
http://localhost:5000/lib/_engine/engine/pointer_binding.dart 179:80                                    <fn>
http://localhost:5000/dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/operations.dart 334:14  _checkAndCall
http://localhost:5000/dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/operations.dart 339:39  dcall
''');

  /// Flutter on Android
  static StackTrace flutterAndroid() => StackTrace.fromString('''
#0      SinglePrettyPrinter.getCaller (package:roggle/src/printers/single_pretty_printer.dart:127:26)
#1      SinglePrettyPrinter.formatFixed (package:roggle/src/printers/single_pretty_printer.dart:258:22)
#2      SinglePrettyPrinter._formatMessage (package:roggle/src/printers/single_pretty_printer.dart:222:19)
#3      SinglePrettyPrinter.log (package:roggle/src/printers/single_pretty_printer.dart:115:12)
#4      Roggle.log (package:roggle/src/roggle.dart:104:31)
#5      Roggle.v (package:roggle/src/roggle.dart:60:5)
#6      _MyHomePageState._incrementCounter (package:flutter_sample_roggle/main.dart:55:14)
#7      _InkResponseState.handleTap (package:flutter/src/material/ink_well.dart:1072:21)
#8      GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:253:24)
#9      TapGestureRecognizer.handleTapUp (package:flutter/src/gestures/tap.dart:627:11)
#10     BaseTapGestureRecognizer._checkUp (package:flutter/src/gestures/tap.dart:306:5)
#11     BaseTapGestureRecognizer.acceptGesture (package:flutter/src/gestures/tap.dart:276:7)
#12     GestureArenaManager.sweep (package:flutter/src/gestures/arena.dart:163:27)
#13     GestureBinding.handleEvent (package:flutter/src/gestures/binding.dart:464:20)
#14     GestureBinding.dispatchEvent (package:flutter/src/gestures/binding.dart:440:22)
#15     RendererBinding.dispatchEvent (package:flutter/src/rendering/binding.dart:337:11)
#16     GestureBinding._handlePointerEventImmediately (package:flutter/src/gestures/binding.dart:395:7)
#17     GestureBinding.handlePointerEvent (package:flutter/src/gestures/binding.dart:357:5)
#18     GestureBinding._flushPointerEventQueue (package:flutter/src/gestures/binding.dart:314:7)
#19     GestureBinding._handlePointerDataPacket (package:flutter/src/gestures/binding.dart:295:7)
#20     _invoke1 (dart:ui/hooks.dart:167:13)
#21     PlatformDispatcher._dispatchPointerDataPacket (dart:ui/platform_dispatcher.dart:341:7)
#22     _dispatchPointerDataPacket (dart:ui/hooks.dart:94:31)
''');

  /// Flutter on iOS
  static StackTrace flutterIOS() => StackTrace.fromString('''
#0      SinglePrettyPrinter.getCaller (package:roggle/src/printers/single_pretty_printer.dart:127:26)
#1      SinglePrettyPrinter.formatFixed (package:roggle/src/printers/single_pretty_printer.dart:258:22)
#2      SinglePrettyPrinter._formatMessage (package:roggle/src/printers/single_pretty_printer.dart:222:19)
#3      SinglePrettyPrinter.log (package:roggle/src/printers/single_pretty_printer.dart:115:12)
#4      Roggle.log (package:roggle/src/roggle.dart:104:31)
#5      Roggle.v (package:roggle/src/roggle.dart:60:5)
#6      _MyHomePageState._incrementCounter (package:flutter_sample_roggle/main.dart:55:14)
#7      _InkResponseState.handleTap (package:flutter/src/material/ink_well.dart:1072:21)
#8      GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:253:24)
#9      TapGestureRecognizer.handleTapUp (package:flutter/src/gestures/tap.dart:627:11)
#10     BaseTapGestureRecognizer._checkUp (package:flutter/src/gestures/tap.dart:306:5)
#11     BaseTapGestureRecognizer.acceptGesture (package:flutter/src/gestures/tap.dart:276:7)
#12     GestureArenaManager.sweep (package:flutter/src/gestures/arena.dart:163:27)
#13     GestureBinding.handleEvent (package:flutter/src/gestures/binding.dart:464:20)
#14     GestureBinding.dispatchEvent (package:flutter/src/gestures/binding.dart:440:22)
#15     RendererBinding.dispatchEvent (package:flutter/src/rendering/binding.dart:337:11)
#16     GestureBinding._handlePointerEventImmediately (package:flutter/src/gestures/binding.dart:395:7)
#17     GestureBinding.handlePointerEvent (package:flutter/src/gestures/binding.dart:357:5)
#18     GestureBinding._flushPointerEventQueue (package:flutter/src/gestures/binding.dart:314:7)
#19     GestureBinding._handlePointerDataPacket (package:flutter/src/gestures/binding.dart:295:7)
#20     _invoke1 (dart:ui/hooks.dart:167:13)
#21     PlatformDispatcher._dispatchPointerDataPacket (dart:ui/platform_dispatcher.dart:341:7)
#22     _dispatchPointerDataPacket (dart:ui/hooks.dart:94:31)
''');

  /// Flutter on Mac
  static StackTrace flutterMac() => StackTrace.fromString('''
#0      SinglePrettyPrinter.getCaller (package:roggle/src/printers/single_pretty_printer.dart:127:26)
#1      SinglePrettyPrinter.formatFixed (package:roggle/src/printers/single_pretty_printer.dart:258:22)
#2      SinglePrettyPrinter._formatMessage (package:roggle/src/printers/single_pretty_printer.dart:222:19)
#3      SinglePrettyPrinter.log (package:roggle/src/printers/single_pretty_printer.dart:115:12)
#4      Roggle.log (package:roggle/src/roggle.dart:104:31)
#5      Roggle.v (package:roggle/src/roggle.dart:60:5)
#6      _MyHomePageState._incrementCounter (package:flutter_sample_roggle/main.dart:53:14)
#7      _InkResponseState.handleTap (package:flutter/src/material/ink_well.dart:1072:21)
#8      GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:253:24)
#9      TapGestureRecognizer.handleTapUp (package:flutter/src/gestures/tap.dart:627:11)
#10     BaseTapGestureRecognizer._checkUp (package:flutter/src/gestures/tap.dart:306:5)
#11     BaseTapGestureRecognizer.acceptGesture (package:flutter/src/gestures/tap.dart:276:7)
#12     GestureArenaManager.sweep (package:flutter/src/gestures/arena.dart:163:27)
#13     GestureBinding.handleEvent (package:flutter/src/gestures/binding.dart:464:20)
#14     GestureBinding.dispatchEvent (package:flutter/src/gestures/binding.dart:440:22)
#15     RendererBinding.dispatchEvent (package:flutter/src/rendering/binding.dart:337:11)
#16     GestureBinding._handlePointerEventImmediately (package:flutter/src/gestures/binding.dart:395:7)
#17     GestureBinding.handlePointerEvent (package:flutter/src/gestures/binding.dart:357:5)
#18     GestureBinding._flushPointerEventQueue (package:flutter/src/gestures/binding.dart:314:7)
#19     GestureBinding._handlePointerDataPacket (package:flutter/src/gestures/binding.dart:295:7)
#20     _invoke1 (dart:ui/hooks.dart:167:13)
#21     PlatformDispatcher._dispatchPointerDataPacket (dart:ui/platform_dispatcher.dart:341:7)
#22     _dispatchPointerDataPacket (dart:ui/hooks.dart:94:31)
''');

  /// Flutter on Windows
  static StackTrace flutterWindows() => StackTrace.fromString('''
#0      SinglePrettyPrinter.getCaller (package:roggle/src/printers/single_pretty_printer.dart:127:26)
#1      SinglePrettyPrinter.formatFixed (package:roggle/src/printers/single_pretty_printer.dart:259:22)
#2      SinglePrettyPrinter._formatMessage (package:roggle/src/printers/single_pretty_printer.dart:223:19)
#3      SinglePrettyPrinter.log (package:roggle/src/printers/single_pretty_printer.dart:115:12)
#4      Roggle.log (package:roggle/src/roggle.dart:104:31)
#5      Roggle.v (package:roggle/src/roggle.dart:60:5)
#6      _MyHomePageState._incrementCounter (package:flutter_sample_roggle/main.dart:52:14)
#7      _InkResponseState._handleTap (package:flutter/src/material/ink_well.dart:1005:21)
#8      GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:198:24)
#9      TapGestureRecognizer.handleTapUp (package:flutter/src/gestures/tap.dart:613:11)
#10     BaseTapGestureRecognizer._checkUp (package:flutter/src/gestures/tap.dart:298:5)
#11     BaseTapGestureRecognizer.acceptGesture (package:flutter/src/gestures/tap.dart:269:7)
#12     GestureArenaManager.sweep (package:flutter/src/gestures/arena.dart:157:27)
#13     GestureBinding.handleEvent (package:flutter/src/gestures/binding.dart:449:20)
#14     GestureBinding.dispatchEvent (package:flutter/src/gestures/binding.dart:425:22)
#15     RendererBinding.dispatchEvent (package:flutter/src/rendering/binding.dart:329:11)
#16     GestureBinding._handlePointerEventImmediately (package:flutter/src/gestures/binding.dart:380:7)
#17     GestureBinding.handlePointerEvent (package:flutter/src/gestures/binding.dart:344:5)
#18     GestureBinding._flushPointerEventQueue (package:flutter/src/gestures/binding.dart:302:7)
#19     GestureBinding._handlePointerDataPacket (package:flutter/src/gestures/binding.dart:285:7)
#20     _rootRunUnary (dart:async/zone.dart:1442:13)
#21     _CustomZone.runUnary (dart:async/zone.dart:1335:19)
#22     _CustomZone.runUnaryGuarded (dart:async/zone.dart:1244:7)
#23     _invoke1 (dart:ui/hooks.dart:170:10)
#24     PlatformDispatcher._dispatchPointerDataPacket (dart:ui/platform_dispatcher.dart:331:7)
#25     _dispatchPointerDataPacket (dart:ui/hooks.dart:94:31)
''');
}
