import 'package:flutter_test/flutter_test.dart';
import 'package:patch_pal/src/domain/models/patch_info.dart';
import 'package:patch_pal/src/domain/models/patch_item.dart';

import '../../../fixture/fixture.dart';

void main() {
  group('PatchInfo test from Json', () {
    test(
      'should return PatchInfo ',
      () {
        final response = fixture('patch_info.json');
        final patchInfo = PatchInfo.fromJson(response);
        expect(patchInfo, isA<PatchInfo>());
        expect(patchInfo.version, '1.0.0');
        expect(patchInfo.items, isA<List<PatchItem>>());
        expect(patchInfo.updates, isA<List<String>>());
      },
    );
  });
}
