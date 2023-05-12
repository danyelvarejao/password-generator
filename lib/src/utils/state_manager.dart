import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class StateManager {
  static final Map<Type, StateManagerController> _controllers = {};

  static StateManagerController put(StateManagerController controller) {
    final Type type = controller.runtimeType;

    bool oldRemoved = false;
    if (_controllers[type] != null) {
      oldRemoved = _controllers.remove(type) != null;
    }

    if (_controllers[type] == null) {
      _controllers[type] = controller;
      if (kDebugMode) {
        print('[StateManager]: $type ${oldRemoved ? 'replaced' : 'created'}.');
      }
    }

    return controller;
  }

  static T get<T extends StateManagerController>() {
    if (_controllers[T] != null) return _controllers[T] as T;

    throw '[StateManager]: Cannot find $T! Needs to create with "StateManager.put($T());"';
  }

  static void _delete(Type controllerType) {
    if (_controllers[controllerType] != null &&
        _controllers.remove(controllerType) != null) {
      if (kDebugMode) {
        print('[StateManager]: $controllerType deleted.');
      }
    }
  }
}

abstract class StateManagerController extends ChangeNotifier {
  void update() => notifyListeners();

  @override
  void dispose() {
    super.dispose();
    StateManager._delete(runtimeType);
  }
}

abstract class StateManagerView<T extends StateManagerController>
    extends StatelessWidget {
  const StateManagerView({Key? key}) : super(key: key);

  T get controller => StateManager.get<T>();

  // ignore: non_constant_identifier_names
  Widget HBuilder(Widget Function() builder) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => builder.call(),
    );
  }
}

class StateManagerBuilder<T extends StateManagerController> extends StateManagerView<T> {
  const StateManagerBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function() builder;

  @override
  Widget build(BuildContext context) => HBuilder(builder);
}
