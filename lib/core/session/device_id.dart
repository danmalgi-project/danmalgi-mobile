import 'package:danmalgi_mobile/core/storage/storage_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'device_id.g.dart';

@Riverpod(keepAlive: true)
Future<String> deviceId(Ref ref) async {
  final secure = ref.watch(secureStorageProvider);

  final existing = await secure.getDeviceId();
  if (existing != null) return existing;

  final newId = const Uuid().v4();
  await secure.createDeviceId(deviceId: newId);
  return newId;
}
