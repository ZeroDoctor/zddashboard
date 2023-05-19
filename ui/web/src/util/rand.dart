import 'dart:math';

final String charset =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

String randString(int n) {
  String str = "";

  for (int i = 0; i < n; i++) {
    str += charset[Random().nextInt(charset.length)];
  }

  return str;
}
