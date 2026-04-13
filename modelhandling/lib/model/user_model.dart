class User {
  final int? id;
  final String name;
  final String email;

  User({this.id, required this.name, required this.email});

  // From database
  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], name: map['name'], email: map['email']);
  }

  // To database
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email};
  }
}