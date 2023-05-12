import 'package:flutter/services.dart';

import '../../../theme/colors.dart';
import '../../../utils/state_manager.dart';
import '../services/password_manager.dart';

enum PasswordStrength {
  tooWeak,
  weak,
  medium,
  strong;

  String get name {
    switch (this) {
      case PasswordStrength.tooWeak:
        return 'TOO WEAK!';
      case PasswordStrength.weak:
        return 'WEAK';
      case PasswordStrength.medium:
        return 'MEDIUM';
      case PasswordStrength.strong:
        return 'STRONG';
    }
  }

  Color get color {
    switch (this) {
      case PasswordStrength.tooWeak:
        return AppColors.red;
      case PasswordStrength.weak:
        return AppColors.orange;
      case PasswordStrength.medium:
        return AppColors.yellow;
      case PasswordStrength.strong:
        return AppColors.neonGreen;
    }
  }
}

class HomeController extends StateManagerController {
  int charactersLength = 10;
  bool includeUppercaseCharacters = true;
  bool includeLowercaseCharacters = true;
  bool includeNumbersCharacters = true;
  bool includeSymbolsCharacters = true;

  String passwordGenerated = '';

  void generatePassword() {
    passwordGenerated = PasswordManager.generate(
      length: charactersLength,
      includeUppercase: includeUppercaseCharacters,
      includeLowercase: includeLowercaseCharacters,
      includeNumbers: includeNumbersCharacters,
      includeSymbols: includeSymbolsCharacters,
    );

    update();
  }

  bool canGeneratePassword() {
    if (charactersLength <= 0 || charactersLength > 20) {
      return false;
    }

    if (!includeUppercaseCharacters &&
        !includeLowercaseCharacters &&
        !includeNumbersCharacters &&
        !includeSymbolsCharacters) {
      return false;
    }

    return true;
  }

  PasswordStrength getPasswordStrength() {
    if (charactersLength < 6) {
      return PasswordStrength.tooWeak;
    } else if (charactersLength < 10) {
      return PasswordStrength.weak;
    } else if (charactersLength < 15) {
      return PasswordStrength.medium;
    }
    return PasswordStrength.strong;
  }

  Future<void> copyPassword({required Function() onSuccess, required Function() onFailed}) async {
    if (passwordGenerated.isEmpty) {
      onFailed.call();
      return;
    }

    await Clipboard.setData(ClipboardData(text: passwordGenerated));
    onSuccess.call();
  }
}
