import 'package:logger/logger.dart';

/// Do nothing
class DumpOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // dump event
  }
}
