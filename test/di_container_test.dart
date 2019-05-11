import 'package:di_container/di_container.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests for Provide type', () {
    setUp(() {
      Injector.provide(
        builder: () => A(),
      );
    });

    test("Get instance auto assign type", () {
      A a1 = Injector.get();
      A a2 = Injector.get();
      expect(a1.hashCode != a2.hashCode, true);
    });

    test("Get instance with assign specify type", () {
      A a1 = Injector.get<A>();
      A a2 = Injector.get<A>();
      expect(a1.hashCode != a2.hashCode, true);
    });

    test("Get instance fail with class is not register", () {
      // Clear
      Injector.clear();

      try {
        A a = Injector.get();
      } catch (e) {
        expect(e.toString(), "class A is not register");
      }
    });
  });


  group('A group of tests for Singleton type', () {
    setUp(() {
      Injector.single(
        builder: () => A(),
      );
    });

    test("Get instance auto assign type", () {
      A a1 = Injector.get();
      A a2 = Injector.get();
      expect(a1.hashCode == a2.hashCode, true);
    });

    test("Get instance with assign specify type", () {
      A a1 = Injector.get<A>();
      A a2 = Injector.get<A>();
      expect(a1.hashCode == a2.hashCode, true);
    });

    test("Get instance fail with class is not register", () {
      // Clear
      Injector.clear();

      try {
        A a = Injector.get();
      } catch (e) {
        expect(e.toString(), "class A is not register");
      }
    });
  });

  group('A group of tests for multiple instance with "name" key', () {
    setUp(() {
      Injector.single(
        name: "C1",
        builder: () => C("C1"),
      );

      Injector.single(
        name: "C2",
        builder: () => C("C2"),
      );
    });

    test("Get instance auto assign type", () {
      C c1 = Injector.get(name: "C1");
      C c2 = Injector.get(name: "C2");
      expect(c1.name, "C1");
      expect(c2.name, "C2");
    });

    test("Get instance with assign specify type", () {
      C c1 = Injector.get<C>(name: "C1");
      C c2 = Injector.get<C>(name: "C2");
      expect(c1.name, "C1");
      expect(c2.name, "C2");
    });

    test("Get instance fail with the class is not register", () {
      // Clear
      Injector.clear();
      try {
        C c3 = Injector.get();
      } catch (e) {
        expect(e.toString(), "class C is not register");
      }
    });

    test("Get instance fail with the class with name is not register", () {
      // Clear
      Injector.clear();
      String name = "C3";
      try {
        C c3 = Injector.get(name: name);
      } catch (e) {
        expect(e.toString(), "class C with name '$name' is not register");
      }
    });
  });
}

class A {}

class B {}

class C {
  String name;

  C(this.name);
}

