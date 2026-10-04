import 'dart:convert';

class PrefKey<T> {
  final String name;
  final T defaultValue;
  final Object? Function(T value) encode;
  final T? Function(Object raw) decode;

  const PrefKey(
    this.name, {
    required this.defaultValue,
    required this.encode,
    required this.decode,
  });

  static PrefKey<bool> flag(String name, {bool defaultValue = false}) =>
      PrefKey<bool>(
        name,
        defaultValue: defaultValue,
        encode: (v) => v,
        decode: (raw) => raw is bool ? raw : null,
      );

  static PrefKey<int> integer(String name, {int defaultValue = 0}) =>
      PrefKey<int>(
        name,
        defaultValue: defaultValue,
        encode: (v) => v,
        decode: (raw) => raw is int ? raw : null,
      );

  static PrefKey<String?> string(String name) => PrefKey<String?>(
    name,
    defaultValue: null,
    encode: (v) => v,
    decode: (raw) => raw is String ? raw : null,
  );

  static PrefKey<E> enumByName<E extends Enum>(
    String name,
    List<E> values, {
    required E defaultValue,
  }) => PrefKey<E>(
    name,
    defaultValue: defaultValue,
    encode: (v) => v.name,
    decode: (raw) => raw is String ? values.asNameMap()[raw] : null,
  );

  static PrefKey<T?> json<T>(
    String name, {
    required Map<String, Object?> Function(T value) toJson,
    required T Function(Map<String, Object?> json) fromJson,
  }) => PrefKey<T?>(
    name,
    defaultValue: null,
    encode: (v) => v == null ? null : jsonEncode(toJson(v)),
    decode: (raw) {
      if (raw is! String) return null;
      try {
        return fromJson(jsonDecode(raw) as Map<String, Object?>);
      } catch (_) {
        return null; // 형식이 바뀌었거나 깨진 데이터 → 없는 것으로 취급
      }
    },
  );
}
