class Person {
  final String name;
  final String email;

  Person(this.name, this.email);
}

class User extends Person {
  final String uid;

  User({required this.uid, required String name, required String email}) : super(name, email);
}
