class Review {
  final String id;
  final String? title;
  final double ratings;
  // final String user;
  final Map<String, dynamic> user;
  final String service;
  final String createdAt;
  final String updatedAt;

  Review({
    required this.id,
    this.title,
    required this.ratings,
    required this.user,
    required this.service,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      title: json['title'] ?? "",
      ratings: json['ratings'].toDouble(),
      user: json['user'],
      service: json['service'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'ratings': ratings,
      'user': user,
      'service': service,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
    if (title != null) data['title'] = title;
    return data;
  }
}
