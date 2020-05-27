import 'dart:io';

import 'package:test/test.dart';

const templateFile = 'test/fixtures/test_spec.yaml';
const activeFile = 'test/fixtures/_active_spec.yaml';

Future<ProcessResult> runHoriHori(Iterable<String> args) => Process.run(
      'dart',
      [
        'main.dart',
        '-f',
        activeFile,
        ...args,
      ],
    );

void main() {
  setUp(() => File.fromUri(Uri.parse(templateFile)).copy(activeFile));

  tearDownAll(() => File.fromUri(Uri.parse(activeFile)).delete());

  group('Hori-Hori CLI', () {
    group('hori-hori version', () {
      test('should print version information', () async {
        final result = await runHoriHori(['version']);

        expect(result.exitCode, 0);
        expect(result.stdout, contains('1.2.3+4'));
      });
    });

    group('hori-hori bump', () {
      <String, String>{
        'major': '2.0.0',
        'minor': '1.3.0',
        'patch': '1.2.4',
        'build': '1.2.3+5',
      }.forEach((key, value) => test('$key bumps $key version', () async {
            final bumpResult = await runHoriHori(['bump', key]);
            expect(bumpResult.exitCode, 0);

            final versionResult = await runHoriHori(['version']);
            expect(versionResult.stdout, contains(value));
          }));
    });
  });
}
