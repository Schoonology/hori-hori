import 'dart:io';

import 'package:args/command_runner.dart';

import 'commands/bump.dart';
import 'commands/version.dart';

const defaultCommand = 'version';
const defaultInputFile = 'pubspec.yaml';

abstract class HoriHoriCommand extends Command {
  String get filePath => globalResults['file'];

  Uri get fileUri => Uri.file(filePath);

  Future<List<String>> readLines() => File.fromUri(fileUri).readAsLines();

  Future<void> writeLines(Iterable<String> lines) =>
      File.fromUri(fileUri).writeAsString(lines.join('\n') + '\n');

  Future<void> transformInputFile(String Function(String) transform) async =>
      writeLines((await readLines()).map(transform));
}

CommandRunner buildRunner() => CommandRunner(
      'hori-hori',
      'A Swiss Army knife for versioning and releasing Flutter-based software.',
    )
      ..addCommand(BumpCommand())
      ..addCommand(VersionCommand())
      ..argParser.addOption('file',
          abbr: 'f',
          defaultsTo: 'pubspec.yaml',
          help: 'Specify an alternate pubspec file.');
