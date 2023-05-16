import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../utils/functions.dart';
import '../../../utils/state_manager.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_checkbox_list_tile.dart';
import 'widgets/strength_square.dart';

class HomeScreen extends StateManagerView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryDarkGrey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Password Generator',
                    style: TextStyle(color: AppColors.grey),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: AppColors.darkGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HBuilder(
                          () => Flexible(
                            child: controller.passwordGenerated.isNotEmpty
                                ? Text(
                                    controller.passwordGenerated,
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  )
                                : Text(
                                    'PTx1f5DaFX',
                                    style: Theme.of(context).textTheme.headlineMedium?.apply(
                                          color: AppColors.grey,
                                        ),
                                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async => await controller.copyPassword(
                            onSuccess: () {
                              Functions.showSnackBar(
                                context,
                                'Successfully copied to clipboard.',
                                backgroundColor: AppColors.neonGreen,
                              );
                            },
                            onFailed: () {
                              Functions.showSnackBar(
                                context,
                                'Failed to copy password, password is empty.',
                                backgroundColor: AppColors.red,
                              );
                            },
                          ),
                          icon: const Icon(Icons.copy),
                          color: AppColors.neonGreen,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: AppColors.darkGrey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(child: Text('Character Length')),
                            HBuilder(
                              () => Text(
                                controller.charactersLength.toString(),
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
                                  color: AppColors.neonGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 8.0,
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 0,
                            ),
                            trackShape: RectangularSliderTrackShape(),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 14,
                              disabledThumbRadius: 14,
                            ),
                          ),
                          child: HBuilder(
                            () => Slider(
                              min: 1,
                              max: 20,
                              value: controller.charactersLength.toDouble(),
                              activeColor: AppColors.neonGreen,
                              inactiveColor: AppColors.veryDarkGrey,
                              thumbColor: AppColors.almostWhite,
                              onChanged: (double value) {
                                controller.charactersLength = value.toInt();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        HomeCheckBoxListTile(
                          title: 'Include Uppercase Letters',
                          value: controller.includeUppercaseCharacters,
                          onValueChanged: (bool value) {
                            controller.includeUppercaseCharacters = value;
                            controller.update();
                          },
                        ),
                        HomeCheckBoxListTile(
                          title: 'Include Lowercase Letters',
                          value: controller.includeLowercaseCharacters,
                          onValueChanged: (bool value) {
                            controller.includeLowercaseCharacters = value;
                            controller.update();
                          },
                        ),
                        HomeCheckBoxListTile(
                          title: 'Include Numbers',
                          value: controller.includeNumbersCharacters,
                          onValueChanged: (bool value) {
                            controller.includeNumbersCharacters = value;
                            controller.update();
                          },
                        ),
                        HomeCheckBoxListTile(
                          title: 'Include Symbols',
                          value: controller.includeSymbolsCharacters,
                          onValueChanged: (bool value) {
                            controller.includeSymbolsCharacters = value;
                            controller.update();
                          },
                        ),
                        Container(
                          color: AppColors.veryDarkGrey,
                          margin: const EdgeInsets.only(top: 16.0),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  'STRENGTH',
                                  style: TextStyle(color: AppColors.grey),
                                ),
                              ),
                              HBuilder(
                                () {
                                  final passwordStrength = controller.getPasswordStrength();

                                  return Row(
                                    children: [
                                      Text(passwordStrength.name),
                                      const SizedBox(width: 16.0),
                                      StrengthSquare(
                                        color: passwordStrength.index >= PasswordStrength.tooWeak.index ? passwordStrength.color : null,
                                      ),
                                      StrengthSquare(
                                        color: passwordStrength.index >= PasswordStrength.weak.index ? passwordStrength.color : null,
                                      ),
                                      StrengthSquare(
                                        color: passwordStrength.index >= PasswordStrength.medium.index ? passwordStrength.color : null,
                                      ),
                                      StrengthSquare(
                                        color: passwordStrength.index >= PasswordStrength.strong.index ? passwordStrength.color : null,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        HBuilder(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(24.0),
                              backgroundColor: AppColors.neonGreen,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: controller.canGeneratePassword() ? controller.generatePassword : null,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'GENERATE',
                                  style: TextStyle(
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: AppColors.veryDarkGrey),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
