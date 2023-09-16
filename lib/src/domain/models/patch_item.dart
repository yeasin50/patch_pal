import 'dart:convert';

class PatchItem {
  /// create a Path object for each key/value pair in the patch
  /// like if you like to enable rain, you will have a PatchItem
  /// with name: 'enable rain' and value: true
  const PatchItem({
    required this.name,
    required this.value,
    this.message,
  });

  final String name;
  final dynamic value;
  final String? message;

  PatchItem copyWith({
    String? name,
    dynamic value,
    String? message,
  }) {
    return PatchItem(
      name: name ?? this.name,
      value: value ?? this.value,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'value': value});
    if (message != null) {
      result.addAll({'message': message});
    }

    return result;
  }

  factory PatchItem.fromMap(Map<String, dynamic> map) {
    return PatchItem(
      name: map['name'] ?? '',
      value: map['value'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PatchItem.fromJson(String source) =>
      PatchItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'PatchItem(name: $name, value: $value, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PatchItem &&
        other.name == name &&
        other.value == value &&
        other.message == message;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ message.hashCode;
}
