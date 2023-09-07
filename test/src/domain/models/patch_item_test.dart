import 'package:flutter_test/flutter_test.dart';
import 'package:patch_pal/src/domain/models/patch_item.dart';

void main() {
  group('Value Equality', () {
    test('same value should be identical', () {
      final patchItem1 = PatchItem(name: 'enable rain', value: true);
      final patchItem2 = PatchItem(name: 'enable rain', value: true);
      expect(patchItem1, patchItem2);
    });

    test('different value should not be identical', () {
      final patchItem1 = PatchItem(name: 'enable rain', value: true);
      final patchItem2 = PatchItem(name: 'enable rain', value: false);
      expect(patchItem1, isNot(patchItem2));
    });

    test('different value should not be identical message', () {
      final patchItem1 = PatchItem(name: 'enable rain', value: true);
      final patchItem2 = PatchItem(name: 'enable rain', value: false, message: 'test');
      expect(patchItem1, isNot(patchItem2));
    });
  });
  group('should return PatchItem', () {
    group('From Json', () {
      test('handling empty message', () {
        final data = {
          "name": "enable rain",
          "value": true,
        };

        final patchItem = PatchItem.fromMap(data);
        expect(patchItem, isA<PatchItem>());
        expect(patchItem.name, 'enable rain');
      });

      test('handle with message', () {
        final data = {
          "name": "enable rain",
          "value": true,
          "message": "test",
        };

        final patchItem = PatchItem.fromMap(data);
        expect(patchItem, isA<PatchItem>());
        expect(patchItem.message, 'test');
      });

      test('handle int type value', ()  {
        final data = {
          "name": "enable rain",
          "value": 1,
        };

        final patchItem = PatchItem.fromMap(data);
        expect(patchItem, isA<PatchItem>());
        expect(patchItem.value, 1);
      });

      test('handle null value', ()  {
        final data = {
          "name": "enable rain",
          "value": null,
        };

        final patchItem = PatchItem.fromMap(data);
        expect(patchItem, isA<PatchItem>());
        expect(patchItem.value, null);
      });
    });
  });
}
