import 'package:args/command_runner.dart';

import 'commands/info.dart';

const defaultCommand = 'version';
const defaultInputFile = 'pubspec.yaml';

CommandRunner buildRunner() => CommandRunner(
      'hori-hori',
      'A Swiss Army knife for versioning and releasing Flutter-based software.',
    )..addCommand(InfoCommand());
