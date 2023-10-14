## 0.4.0

- Bumped upper SDK constraint to `<4.0.0`.
- Upgrade logger package from 1.3.0 to 2.0.2+1
- Fixed supported platforms list.
- Added override capability for logger defaults.
- `Level.verbose`, `Level.wtf` and `Level.nothing` have been deprecated and are replaced
  by `Level.trace`, `Level.fatal` and `Level.off`.
  Additionally `Level.all` has been added.
- Added `addLogListener`, `removeLogListener`, `addOutputListener`, `removeOutputListener` and ``isClosed`.
- Added `time` to LogEvent.

### Breaking changes

- `log` signature has been changed to closer match dart's developer `log` function and allow for
  future
  optional parameters.

  Additionally, `time` has been added as an optional named parameter to support providing custom
  timestamps for LogEvents instead of `DateTime.now()`.

  #### Migration:
    - Before:
      ```dart
      logger.e("An error occurred!", error, stackTrace);
      ```
    - After:
      ```dart
      logger.e("An error occurred!", error: error, stackTrace: stackTrace);
      ```
- `init` and `close` methods of `LogFilter`, `LogOutput` and `LogPrinter` are now async along
  with `Logger.close()`.
  (Fixes FileOutput)
- Levels are now sorted by their respective value instead of the enum index (Order didn't change).

## 0.3.2

- upgrade: Support Dart version to 3.0.0
- upgrade: Upgrade logger package to 1.3.0

## 0.3.1

- upgrade: Upgrade logger package to 1.2.2

## 0.3.0

- feature: Added `printLocation` parameter. If set to `true`, location of caller will be output to the log.
- feature: Added `printFunctionName` parameter. If set to `true`, function name of caller will be output to the log.
- fix: Unified Caller format across all platforms. Because changed to use `Trace.current()` instead of `StackTrace.current` when getting a Caller.
- fix: Changed default emojis.

## 0.2.1+1

- fix: Fixed minimum version of meta to 1.7.0

## 0.2.1

- fix: Deleted beginning space when `defaultStackTracePrefix` is ​​empty string

## 0.2.0

- fix: Changed the message property type of Roggle.log() from `Object' to 'Object?'

## 0.1.0

- Update version

## 0.1.0-dev.2

- Support crashlytics

## 0.1.0-dev.1

- First version