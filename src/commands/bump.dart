import 'dart:io';

import 'package:args/command_runner.dart';

import '../cli.dart';
import '../pubspec.dart';

abstract class VersionTransformCommand extends HoriHoriCommand {
  Version transform(Version version);

  void run() async {
    final inputFile = File.fromUri(fileUri);

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
}

class _BumpMajorCommand extends VersionTransformCommand {
  @override
  String get description => 'Bump major version.';

  @override
  String get name => 'major';

  @override
  Version transform(Version version) => version.nextMajor;
}

class _BumpMinorCommand extends VersionTransformCommand {
  @override
  String get description => 'Bump minor version.';

  @override
  String get name => 'minor';

  @override
  Version transform(Version version) => version.nextMinor;
}

class _BumpPatchCommand extends VersionTransformCommand {
  @override
  String get description => 'Bump patch version.';

  @override
  String get name => 'patch';

  @override
  Version transform(Version version) => version.nextPatch;
}

class _BumpBuildCommand extends VersionTransformCommand {
  @override
  String get description => 'Bump build number.';

  @override
  String get name => 'build';

  @override
  Version transform(Version version) =>
      Version(version.major, version.minor, version.patch,
          build: _incrementBuild(version.build));

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
