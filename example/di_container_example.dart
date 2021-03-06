import 'package:di_container/di_container.dart';

main() {
  /**
   * You don't need assign type,
   * the type will auto map with type return in builder function
   *
   * With example class A and class B
   * the type map with type A because builder return a instance of A
   * the type map with type B because builder return a instance of B
   *
   * But with example abstract class C
   * you must assign type to register like this: Injector.register<C>*
   */

  // Type Provide
  Injector.provide(
    builder: () => A(),
  );
  A a1 = Injector.get();
  A a2 = Injector.get();

  // a1 != a2
  print("A");
  print(a1.hashCode != a2.hashCode);

  // Type Singleton
  Injector.single(
    builder: () => B(),
  );
  B b1 = Injector.get();
  B b2 = Injector.get();

  // b1 == b2
  print("B");
  print(b1.hashCode == b2.hashCode);


  // with "name" Key
  Injector.single<C>(
    name: "1",
    builder: () => C1(),
  );
  Injector.single<C>(
    name: "2",
    builder: () => C2(),
  );

  C c1 = Injector.get(name: "1");
  C c2 = Injector.get(name: "2");

  c1.hello();
  c2.hello();
}

class A {}

class B {}

abstract class C {
  void hello();
}

class C1 implements C {
  @override
  void hello() {
    print("Hello C1");
  }
}

class C2 implements C {
  @override
  void hello() {
    print("Hello C2");
  }
}
