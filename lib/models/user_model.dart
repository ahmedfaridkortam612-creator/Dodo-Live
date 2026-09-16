class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profileImage;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileImage': profileImage,
    };
  }
}
