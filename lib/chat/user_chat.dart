class UserChat {
  final String id;
  final String name;
  final String email;
  final String? bio;
  final String? phone;
  final String? image;

  UserChat({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.bio,
    this.phone,
  });

  factory UserChat.fromJson(Map<String, dynamic> json) {
    return UserChat(
      id: json["_id"],
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
      image: json['profileImage'],
      phone: json['phone'],
    );
  }
}
