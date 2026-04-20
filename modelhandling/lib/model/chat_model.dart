class Message {
  final int? id;
  final String username;
  final String message;
  final DateTime? createdAt;

  Message({
    this.id,
    required this.username,
    required this.message,
    this.createdAt,
  });
//task 4
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int?,
      username: map['username'] as String,
      message: map['message'] as String,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {'username': username, 'message': message};
  }
}
