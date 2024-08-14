// user_model.dart

class UserModel {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String bio;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      bio: json['bio'],
    );
  }
}
