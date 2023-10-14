import 'package:path/path.dart' as path;

bool kIsWeb = path.Style.platform == path.Style.url;
bool kIsWindows = path.Style.platform == path.Style.windows;
