import 'dart:io';

import 'package:args/command_runner.dart';

import '../cli.dart';
import '../pubspec.dart';

void transformVersion(Version Function(Version) transform) async {
  final inputUri = Uri.file(defaultInputFile);
  final inputFile = File.fromUri(inputUri);

  final lines = await inputFile.readAsLines();
  final output = [];
  for (var line in lines) {
    final version = getVersion(line);
    if (version != null) {
      line = 'version: ${transform(version)}';
    }
    output.add(line);
  }

  await inputFile.writeAsString(output.join('\n') + '\n');
}

class _BumpMajorCommand extends Command {
  @override
  String get description => 'Bump major version.';

  @override
  String get name => 'major';

  void run() async {
    await transformVersion((version) => version.nextMajor);
  }
}

class _BumpMinorCommand extends Command {
  @override
  String get description => 'Bump minor version.';

  @override
  String get name => 'minor';

  void run() async {
    await transformVersion((version) => version.nextMinor);
  }
}

class _BumpPatchCommand extends Command {
  @override
  String get description => 'Bump patch version.';

  @override
  String get name => 'patch';

  void run() async {
    await transformVersion((version) => version.nextPatch);
  }
}

class _BumpBuildCommand extends Command {
  @override
  String get description => 'Bump build number.';

  @override
  String get name => 'build';

  void run() async {
    await transformVersion((version) => Version(
          version.major,
          version.minor,
          version.patch,
          build: _incrementBuild(version.build),
        ));
  }

  String _incrementBuild(List<dynamic> build) {
    bool bumped = false;
    final results = [];

    for (final segment in build) {
      if (segment is int) {
        bumped = true;
        results.add(segment + 1);
      } else {
        results.add(segment);
      }
    }

    if (!bumped) {
      results.add(1);
    }

    return results.join('.');
  }
}

class BumpCommand extends Command {
  @override
  String get description => 'Bump version.';

  @override
  String get name => 'bump';

  BumpCommand() {
    addSubcommand(_BumpMajorCommand());
    addSubcommand(_BumpMinorCommand());
    addSubcommand(_BumpPatchCommand());
    addSubcommand(_BumpBuildCommand());
  }
}
