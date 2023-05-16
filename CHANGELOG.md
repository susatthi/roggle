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