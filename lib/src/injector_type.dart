/// When you call [Injector.get()], Injector will:
/// [Type.provide] return a new instance
/// [Type.singleton] return a instance is exist, if not will create a new instance
enum Type { provide, singleton }