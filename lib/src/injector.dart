import 'package:di_container/src/builder.dart';
import 'package:di_container/src/utils.dart';
import 'package:di_container/src/injector_type.dart';

class Injector {
  Injector._internal();

  static final _builders = Map<String, Builder<dynamic>>();

  static void register<D>({
    Type type,
    String name,
    BuilderFunc<D> builder,
  }) {
    assert(type != null, builder != null);
    String key = getKey(D, name);
    _builders[key] = Builder<D>(type, builder);
  }

  static D get<D>({String name}) {
    String key = getKey(D, name);
    Builder builder = _builders[key];
    if (builder == null) {
      if (name == null) {
        throw "class ${D.toString()} is not register";
      } else {
        throw "class ${D.toString()} with name '$name' is not register";
      }
    }
    return _builders[key].getDependency();
  }

  static void remove<D>({String name}) {
    String key = getKey(D, name);
    _builders.remove(key);
  }

  static void clear() {
    _builders.clear();
  }
}
