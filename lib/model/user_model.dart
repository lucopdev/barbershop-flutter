class UserModel {
  final String id;
  final String name;
  final String lastName;
  final String address;
  final String phone;
  final String password;
  final String observation;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.address,
    required this.phone,
    required this.password,
    required this.observation,
    required this.isAdmin,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        lastName = map["lastName"],
        address = map["address"],
        phone = map["phone"],
        password = map["password"],
        observation = map["observation"],
        isAdmin = map["isAdmin"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "lastName": lastName,
      "address": address,
      "phone": phone,
      "password": password,
      "observation": observation,
      "isAdmin": isAdmin,
    };
  }
}
