import 'package:pub_semver/pub_semver.dart';
export 'package:pub_semver/pub_semver.dart';

final versionRegex = RegExp(r'([\d]+\.[\d]+\.[\d]+(\+[\d]+)?)');
final versionLineRegex = RegExp('version: ${versionRegex.pattern}');

bool isVersionLine(String line) => versionLineRegex.hasMatch(line);

Version getVersion(String line) {
  if (!isVersionLine(line)) {
    return null;
  }

  return Version.parse(versionRegex.firstMatch(line).group(0));
}
