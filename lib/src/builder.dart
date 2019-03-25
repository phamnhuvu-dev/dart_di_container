import 'package:di_container/src/utils.dart';
import 'package:di_container/src/injector_type.dart';

/// [Builder] is class manage states of dependency [D]
/// If [Type.provide] function [getDependency] return new instance [D]
/// If [Type.singleton] function [getDependency] create new instance [D]
/// store in [dependency] variable if [dependency] is null and return [dependency]
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