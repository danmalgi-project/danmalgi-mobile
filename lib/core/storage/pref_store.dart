import 'package:shared_preferences/shared_preferences.dart';

import 'package:danmalgi_mobile/core/storage/pref_key.dart';

class PrefStore {
  final SharedPreferences _prefs;
  final String scope;

  PrefStore(this._prefs, this.scope);

  String _path(String name) => '$scope.$name';

  T get<T>(PrefKey<T> key) {
    final raw = _prefs.get(_path(key.name));
    if (raw == null) return key.defaultValue;
    return key.decode(raw) ?? key.defaultValue;
  }

  Future<void> set<T>(PrefKey<T> key, T value) async {
    final path = _path(key.name);
    switch (key.encode(value)) {
      case null:
        await _prefs.remove(path);
      case bool v:
        await _prefs.setBool(path, v);
      case int v:
        await _prefs.setInt(path, v);
      case double v:
        await _prefs.setDouble(path, v);
      case String v:
        await _prefs.setString(path, v);
      case List<String> v:
        await _prefs.setStringList(path, v);
      case final other:
        throw ArgumentError('${key.name}: 저장할 수 없는 타입 ${other.runtimeType}');
    }
  }

  Future<void> remove<T>(PrefKey<T> key) => _prefs.remove(_path(key.name));

  Future<void> clear() async {
    final keys = _prefs
        .getKeys()
        .where((k) => k.startsWith('$scope.'))
        .toList();
    for (final k in keys) {
      await _prefs.remove(k);
    }
  }
}
