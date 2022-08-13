class Password {
  String id;
  final String appname;
  final String username;
  final String password;

  Password(
      {this.id = '',
      required this.appname,
      required this.username,
      required this.password});

  toJson() {
    return {
      'id': id,
      'appname': appname,
      'username': username,
      'password': password
    };
  }

  static Password fromJson(Map<String, dynamic> json) => Password(
      id: json['id'],
      appname: json['appname'],
      username: json['username'],
      password: json['password']);
}
