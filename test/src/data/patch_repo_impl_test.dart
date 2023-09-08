import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'package:patch_pal/src/data/patch_repo_impl.dart';
import 'package:patch_pal/src/domain/models/patch_exception.dart';

import 'patch_repo_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const testUrl = 'https://github.com/.../patch_file.json';

  group('PatchRepoImpl', () {
    late http.Client mockHttpClient;
    late PatchRepoImpl patchRepo;

    setUp(() {
      mockHttpClient = MockClient();
      patchRepo = PatchRepoImpl(configLocation: testUrl, httpClient: mockHttpClient);
    });

    test('checkUpdate returns PatchInfo on success', () async {
      var responseBody = {
        "packageName": "com.yeasin50.patch_pal",
        "version": "1.0.0",
        "items": [
          {"name": "number of mango", "value": 3, "message": "added 3 mango"},
        ],
        "updates": ["looking for updates..."]
      };
      final responseMock = http.Response(json.encode(responseBody), 200);

      when(mockHttpClient.get(Uri.parse(testUrl))).thenAnswer((_) async => responseMock);

      final result = await patchRepo.checkUpdate();

      expect(result, isNotNull);
      expect(result.version, '1.0.0');
      expect(result.items.length, 1);
      expect(result.items.first.name, 'number of mango');
      expect(result.items.first.value, 3);
      expect(result.items.first.message, 'added 3 mango');
      expect(result.updates.length, 1);
    });

    test('checkUpdate throws PatchNetworkException on failure', () async {
      when(
        mockHttpClient.get(Uri.parse(testUrl)),
      ).thenThrow(PatchNetworkException());

      expect(patchRepo.checkUpdate(), throwsA(TypeMatcher<PatchNetworkException>()));
    });

    test('checkUpdate throws PatchUnsupportedFormat on empty body', () async {
      when(mockHttpClient.get(Uri.parse(testUrl))).thenAnswer(
        (_) async => http.Response('{}', 200),
      );
      final result = patchRepo.checkUpdate();
      expect(result, throwsException);
      expect(result, throwsA(TypeMatcher<PatchUnsupportedFormat>()));
    });
  });
}
