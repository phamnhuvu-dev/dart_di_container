/// This file contain defines and helper functions
typedef BuilderFunc<D> = D Function();

String getKey(Type type, String name) {
  return name == null ? type.toString() : type.toString() + name;
}
