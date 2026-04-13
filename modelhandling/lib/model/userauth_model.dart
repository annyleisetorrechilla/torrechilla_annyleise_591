class UserModel {
  final int? id;
  final String username;
  final String password;

  UserModel({this.id, required this.username, required this.password});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password};
  }
}
