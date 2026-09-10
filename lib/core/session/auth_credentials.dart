import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthCredentials {
  String? token;
}

final authCredentialsProvider = Provider<AuthCredentials>(
  (ref) => AuthCredentials(),
);
