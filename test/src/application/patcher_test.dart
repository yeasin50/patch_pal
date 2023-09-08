import 'package:flutter_test/flutter_test.dart';
import 'package:patch_pal/src/application/patch_pal.dart';
import 'package:patch_pal/src/domain/models/patch_item.dart';

void main() {
  //!testing with a json file from github
  //!'https://raw.githubusercontent.com/yeasin50/AssetsFor_/master/apps/patch_pal/test.json'
  group('Patcher', () {
    late PatchPal patcher;

    setUp(() async {
      patcher = PatchPal();
      await patcher.setUp('https://raw.githubusercontent.com/yeasin50/AssetsFor_/master/apps/patch_pal/test.json');
    });
    test(' should be singleton', () {
      expect(PatchPal(), PatchPal());
    });

    test('should be ready after setup', () async {
      expect(patcher.isReady, true);
      expect(patcher.data, isNotNull);
      expect(patcher.data?.items, isNotEmpty);
      expect(patcher.data?.updates, isNotEmpty);
    });

    test('get PatchInfo from fromName ', () async {
      final item = patcher.getItem('rain');
      expect(item, isNotNull);
      expect(item?.value, true);
      expect(item?.message, isNotEmpty);
    });

    test('return null if item not found', () async {
      final item = patcher.getItem('not_found');
      expect(item, isNull);
    });
  });
}
