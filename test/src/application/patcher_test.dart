import 'package:flutter_test/flutter_test.dart';
import 'package:patch_pal/src/application/patch_pal.dart';

void main() {
  //!testing with a json file from github
  //!'https://raw.githubusercontent.com/yeasin50/AssetsFor_/master/apps/patch_pal/test.json'
  group('PatchPal', () {
    setUp(() async {
      await PatchPal.setUp(
          'https://raw.githubusercontent.com/yeasin50/AssetsFor_/master/apps/patch_pal/test.json');
    });
    // test(' should be singleton', () {
    //   expect(PatchPal(), PatchPal());
    // });

    test('should be ready after setup', () async {
      expect(PatchPal.isReady, true);
      expect(PatchPal.data, isNotNull);
      expect(PatchPal.data?.items, isNotEmpty);
      expect(PatchPal.data?.updates, isNotEmpty);
    });

    test('get PatchInfo from fromName ', () async {
      final item = PatchPal.getItem('rain');
      expect(item, isNotNull);
      expect(item?.value, true);
      expect(item?.message, isNotEmpty);
    });

    test('return null if item not found', () async {
      final item = PatchPal.getItem('not_found');
      expect(item, isNull);
    });
  });
}
