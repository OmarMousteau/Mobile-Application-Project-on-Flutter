class UserModel {
  String? fullName;
  String? email;
  String? number;

  UserModel({this.fullName, this.email, this.number});

  // data from the server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      fullName: map['fullName'],
      email: map['email'],
      number: map['number'],

    );

  }


  // send data to our server  

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'number': number 
    };
  }

}