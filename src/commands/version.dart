import 'dart:io';

import '../cli.dart';

class VersionCommand extends HoriHoriCommand {
  @override
  String get description => 'Print version information, then exit.';

  @override
  String get name => 'version';

  @override
  bool get takesArguments => false;

  void run() async {
    print('Hori-Hori version 1.0.0');
    print('Dart version ${Platform.version}');
  }
}
