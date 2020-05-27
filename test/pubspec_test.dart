import 'package:test/test.dart';

import '../src/pubspec.dart';

void main() {
  group('isVersionLine()', () {
    test('should match `version: 1.2.3', () {
      expect(isVersionLine('version: 1.2.3'), true);
    });

    test('should not match `version:`', () {
      expect(isVersionLine('version:'), false);
    });

    test('should not match `version: 1', () {
      expect(isVersionLine('version: 1'), false);
    });
  });

  group('getVersion()', () {
    test('should return a parsed Version for `version: 1.2.3', () {
      expect(getVersion('version: 1.2.3'), Version(1, 2, 3));
    });

    test('should return `null` for `nonsense', () {
      expect(getVersion('nonsense'), null);
    });

    test('should return `null` for `version:`', () {
      expect(getVersion('version:'), null);
    });

    test('should return `null` for `version: 1', () {
      expect(getVersion('version: 1'), null);
    });
  });
}
