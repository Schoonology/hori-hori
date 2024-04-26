import 'dart:io';

import '../cli.dart';
import '../pubspec.dart';

class UpdatedCommand extends HoriHoriCommand {
  @override
  String get description =>
      '''Returns 0 if the version in the pubspec file is newer than the provided version, 1 otherwise.

Example: hori-hori updated 1.2.3+4''';

  @override
  String get invocation =>
      super.invocation.replaceAll('[arguments]', '[version]');

  @override
  String get name => 'updated';

  @override
  String get summary => 'Check if the version has been updated.';

  Version? get other {
    try {
      final argument = argResults?.arguments.single;
      if (argument == null) {
        return null;
      }

      return Version.parse(argument);
    } on FormatException catch (_) {
      rethrow;
    } on Object catch (_) {
      throw new ArgumentError('Command "$name" requires a single argument.');
    }
  }

  void run() async {
    final current = searchVersion(await readLines());

    if (current == null || (other != null && current > other!)) {
      exitCode = 0;
    } else {
      exitCode = 1;
    }
  }
}
