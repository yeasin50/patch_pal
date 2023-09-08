import 'dart:convert';

import 'package:patch_pal/src/domain/models/patch_item.dart';

class PatchInfo {
  const PatchInfo({
    required this.packageName,
    required this.version,
    required this.items,
    required this.updates,
  });

  final String packageName;
  final String version;
  final List<PatchItem> items;
  final List<String> updates;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'packageName': packageName});
    result.addAll({'version': version});
    result.addAll({'items': items.map((x) => x.toMap()).toList()});
    result.addAll({'updates': updates});

    return result;
  }

  factory PatchInfo.fromMap(Map<String, dynamic> map) {
    return PatchInfo(
      packageName: map['packageName'] ?? '',
      version: map['version'] ?? '',
      items: List<PatchItem>.from(map['items']?.map((x) => PatchItem.fromMap(x))),
      updates: List<String>.from(map['updates']),
    );
  }

  String toJson() => json.encode(toMap());
  factory PatchInfo.fromJson(String source) => PatchInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PatchInfo(packageName: $packageName, version: $version, items: $items, updates: $updates)';
  }

  PatchInfo copyWith({
    String? packageName,
    String? version,
    List<PatchItem>? items,
    List<String>? updates,
  }) {
    return PatchInfo(
      packageName: packageName ?? this.packageName,
      version: version ?? this.version,
      items: items ?? this.items,
      updates: updates ?? this.updates,
    );
  }
}
