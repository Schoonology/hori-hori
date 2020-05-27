import 'dart:io';

import 'package:args/command_runner.dart';

import '../cli.dart';
import '../pubspec.dart';

class InfoCommand extends Command {
  @override
  String get description => 'Print version information, then exit.';

  @override
  String get name => 'info';

  void run() async {
    final inputUri = Uri.file(defaultInputFile);
    final inputFile = File.fromUri(inputUri);

    print('Hori-Hori version: 1.0.0');
    print('Dart SDK version: ${Platform.version}');

    final lines = await inputFile.readAsLines();
    for (var line in lines) {
      final version = getVersion(line);
      if (version != null) {
        print('Package version: $version');
      }
    }
  }
}
