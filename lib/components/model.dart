class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? password;
  num? id;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.password,
      this.id});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      id: map['id'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'id': id,
    };
  }
}
