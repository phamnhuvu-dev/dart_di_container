import 'package:di_container/src/utils.dart';
import 'package:di_container/src/injector_type.dart';

class Builder<D> {
  Type type;
  BuilderFunc builderFunc;
  D dependency;

  Builder(this.type, this.builderFunc);

  D getDependency() {
    switch (type) {
      case Type.provide:
        return builderFunc() as D;

      case Type.singleton:
        if (dependency == null) {
          dependency = builderFunc() as D;
        }
        return dependency;

      default:
        return null;
    }
  }
}
