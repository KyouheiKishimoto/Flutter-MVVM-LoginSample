import 'package:flutter/cupertino.dart';

class User {
  String uid;
  String email;
  String password;
  String token;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  User({
    @required this.uid,
    @required this.email,
    @required this.password,
    @required this.token,
  });

  User copyWith({
    String uid,
    String email,
    String password,
    String token,
  }) {
    return new User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, password: $password, token: $token}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email &&
          password == other.password &&
          token == other.token);

  @override
  int get hashCode =>
      uid.hashCode ^ email.hashCode ^ password.hashCode ^ token.hashCode;

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'uid': this.uid,
      'email': this.email,
      'password': this.password,
      'token': this.token,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}