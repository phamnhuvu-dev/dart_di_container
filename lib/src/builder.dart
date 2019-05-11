import 'package:di_container/src/utils.dart';

/// [Builder] is class manage states of dependency [D]
class Builder<D> {
  bool isSingle;
  BuilderFunc builderFunc;
  D dependency;

  Builder(this.isSingle, this.builderFunc);

  D getDependency() {
    if (isSingle) {
      if (dependency == null) {
        dependency = builderFunc() as D;
      }
      return dependency;
    } else {
      return builderFunc() as D;
    }
  }
}