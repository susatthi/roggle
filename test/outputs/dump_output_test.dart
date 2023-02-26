import 'package:roggle/roggle.dart';
import 'package:test/test.dart';

void main() {
  test('output()', () {
    final output = DumpOutput();
    final logEvent = LogEvent(Level.error, '');
    output.output(OutputEvent(logEvent, []));
  });
}
