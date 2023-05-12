import 'dart:math';

abstract class PasswordManager {
  static const uppercaseCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const lowercaseCharacters = 'abcdefghijklmnopqrstuvwxyz';
  static const numbersCharacters = '0123456789';
  static const symbolsCharacters = '~`!@#\$%^&*()-_=+[{]};:\'"\\|,<.>/?';

  static String generate({
    required int length,
    required bool includeUppercase,
    required bool includeLowercase,
    required bool includeNumbers,
    required bool includeSymbols,
  }) {
    String characters = '';

    if (includeUppercase) characters += uppercaseCharacters;
    if (includeLowercase) characters += lowercaseCharacters;
    if (includeNumbers) characters += numbersCharacters;
    if (includeSymbols) characters += symbolsCharacters;

    return List.generate(length, (index) => characters[Random().nextInt(characters.length)]).join();
  }
}
