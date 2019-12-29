import 'dart:math';

import 'package:uuid/uuid.dart';

mixin RandomUtils {
  static const allowedCharacters = "-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

  static String randomSecret([int length = 12]) {
    var secureRandom = Random.secure();
    return List.generate(
      length,
      (index) => allowedCharacters[secureRandom.nextInt(allowedCharacters.length)],
    ).reduce((a, b) => a + b);
  }

  static String randomProxyId() {
    Uuid uuidFactory = Uuid();
    var rand = uuidFactory.v4();
    while (int.tryParse(rand[0]) != null) {
      rand = uuidFactory.v4();
    }
    return rand;
  }
}
