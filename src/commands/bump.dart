import '../cli.dart';
import '../pubspec.dart';

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

extension WithBuild on Version {
  Version get nextBuild => Version(
        major,
        minor,
        patch,
        build: _incrementBuild(build),
      );
}

abstract class VersionTransformCommand extends HoriHoriCommand {
  @override
  bool get takesArguments => false;

  Version transformVersion(Version version);

  void run() async => transformInputFile((line) {
        final version = getVersion(line);
        if (version != null) {
          return 'version: ${transformVersion(version)}';
        }

        return line;
      });
}

class _BumpMajorCommand extends VersionTransformCommand {
  @override
  String get description => 'Bump major version.';

  @override
  String get name => 'major';

  @override
  Version transformVersion(Version version) => version.nextMajor.nextBuild;
}

class _BumpMinorCommand extends VersionTransformCommand {
  @override
  String get description => 'Bump minor version.';

  @override
  String get name => 'minor';

  @override
  Version transformVersion(Version version) => version.nextMinor.nextBuild;
}

class _BumpPatchCommand extends VersionTransformCommand {
  @override
  String get description => 'Bump patch version.';

  @override
  String get name => 'patch';

  @override
  Version transformVersion(Version version) => version.nextPatch.nextBuild;
}

class _BumpBuildCommand extends VersionTransformCommand {
  @override
  String get description => 'Bump build number.';

  @override
  String get name => 'build';

  @override
  Version transformVersion(Version version) => version.nextBuild;
}

class BumpCommand extends HoriHoriCommand {
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
