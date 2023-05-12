import '../screens/home/controllers/home_controller.dart';
import '../utils/state_manager.dart';

abstract class AppControllers {
  static void init() {
    StateManager.put(HomeController());
  }
}
