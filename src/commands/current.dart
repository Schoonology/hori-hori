import '../cli.dart';
import '../pubspec.dart';

class CurrentCommand extends HoriHoriCommand {
  @override
  String get description => 'Prints only the current package version.';

  @override
  String get name => 'current';

  @override
  bool get takesArguments => false;

  void run() async => searchVersion(await readLines());
}
