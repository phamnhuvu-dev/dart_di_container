import 'package:di_container/src/builder.dart';
import 'package:di_container/src/utils.dart';
import 'package:di_container/src/injector_type.dart';

/// class [Injector] contain a [_container] variable and functions to manage [Builder]s
class Injector {
  Injector._internal();

  static final _container = Map<String, Builder<dynamic>>();

  /// [register] function create new [Builder] to manage state of dependency
  /// How [Builder] return a dependency depends on [Type]
  /// [Builder] is stored in [_container] with a key combine by [D] type and [name]
  static void register<D>({
    Type type,
    String name,
    BuilderFunc<D> builder,
  }) {
    assert(type != null, builder != null);
    String key = getKey(D, name);
    _container[key] = Builder<D>(type, builder);
  }

  /// [get] function return a dependency depend on dependency's type [D] and parameter [name]
  static D get<D>({String name}) {
    String key = getKey(D, name);
    Builder builder = _container[key];
    if (builder == null) {
      if (name == null) {
        throw "class ${D.toString()} is not register";
      } else {
        throw "class ${D.toString()} with name '$name' is not register";
      }
    }
    return _container[key].getDependency();
  }

  /// [remove] function remove dependency [D] from [Builder]. This function is used
  /// when need recreate instance type singleton
  static void remove<D>({String name}) {
    String key = getKey(D, name);
    Builder builder = _container[key];
    if (builder != null) builder.dependency = null;
  }

  /// [clear] function clear all dependencies was registered
  static void clear() {
    _container.clear();
  }
}