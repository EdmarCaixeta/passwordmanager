import 'dart:math';

class Password {
  var _random = Random.secure();

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

  int _randomInt(int min, int max) => min + _random.nextInt(max - min);

  String generateRandomString() {
    const upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const specialCaracters = '-_\$%!@.,:?';

    String password = '';

    int upperLength = _randomInt(2, 4);
    int numbersLenght = _randomInt(1, 4);
    int specialCharactersLength = _randomInt(1, 4);
    int lowerCaseLength = _randomInt(2, 4);

    for (int i = 0; i < upperLength; i++) {
      password += upperCase[_random.nextInt(26)];
    }

    for (int i = 0; i < numbersLenght; i++) {
      password += numbers[_random.nextInt(10)];
    }

    for (int i = 0; i < specialCharactersLength; i++) {
      password += specialCaracters[_random.nextInt(10)];
    }

    for (int i = 0; i < lowerCaseLength; i++) {
      password += upperCase[_random.nextInt(26)].toLowerCase();
    }

    var result = password.split('');
    result.shuffle();

    password = result.join();
    return password;
  }
}
