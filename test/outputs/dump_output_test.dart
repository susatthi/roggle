import 'package:roggle/roggle.dart';
import 'package:test/test.dart';

void main() {
  test('output()', () {
    final output = DumpOutput();
    output.output(OutputEvent(Level.error, []));
  });
}
