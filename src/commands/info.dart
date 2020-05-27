import 'dart:io';

import '../cli.dart';
import '../pubspec.dart';

class InfoCommand extends HoriHoriCommand {
  @override
  String get description => 'Print version information, then exit.';

  @override
  String get name => 'info';

  void run() async {
    print('Hori-Hori version: 1.0.0');
    print('Dart SDK version: ${Platform.version}');

    final lines = await readLines();
    for (var line in lines) {
      final version = getVersion(line);
      if (version != null) {
        print('Package version: $version');
      }
    }
  }
}
