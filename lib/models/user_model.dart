class UserModel {
  String id;
  String userName;
  String phone;
  int age;
  String email;

  UserModel({
    this.id = '',
    required this.userName,
    required this.phone,
    required this.age,
    required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          userName: json['userName'],
          phone: json['phone'],
          age: json['age'],
          email: json['email'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'phone': phone,
      'age': age,
      'email': email,
    };
  }
}
