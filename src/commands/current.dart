import 'dart:io';

import '../cli.dart';
import '../pubspec.dart';

class CurrentCommand extends HoriHoriCommand {
  @override
  String get description => 'Prints only the current package version.';

  @override
  String get name => 'current';

  void run() async {
    final lines = await readLines();
    for (var line in lines) {
      final version = getVersion(line);
      if (version != null) {
        stdout.writeln(version);
        return;
      }
    }
  }
}
