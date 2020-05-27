import 'dart:io';

import 'src/cli.dart';

void main(List<String> argv) {
  buildRunner().run(argv).then((value) {
    if (value != null) {
      print(value);
    }
  }).catchError((Object error) {
    stderr.writeln(error);
    exitCode = 1;
  });
}
