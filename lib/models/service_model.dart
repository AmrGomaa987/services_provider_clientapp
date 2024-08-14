import 'dart:convert';

class Service {
  final String id;
  final Map<String, dynamic> provider;
  final String title;
  final String description;
  final String category;
  final String location;
  final double price;
  final double? priceAfterDiscount;
  final String coverImage;
  final List<String>? images;
  final double? ratingsAverage;
  final int ratingsQuantity;
  final List<dynamic> reviews;

  Service({
    required this.id,
    required this.provider,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    this.priceAfterDiscount,
    required this.coverImage,
    required this.location,
    this.images,
    this.ratingsAverage,
    required this.ratingsQuantity,
    required this.reviews,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
        id: json["_id"] ?? "",
        provider: json["provider"] ?? {},
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        category:
            json['category'] != null ? json['category']['name'] ?? "" : "",
        price: json['price'] != null
            ? double.parse(json['price'].toString())
            : 0.0,
        priceAfterDiscount: json['priceAfterDiscount'] != null
            ? double.parse(json['priceAfterDiscount'].toString())
            : null,
        coverImage: json['coverImage'] ?? "",
        images:
            json['images'] != null ? List<String>.from(json['images']) : null,
        ratingsAverage: json['ratingsAverage'] != null
            ? double.parse(json['ratingsAverage'].toString())
            : null,
        ratingsQuantity: json['ratingsQuantity'] != null
            ? int.parse(json['ratingsQuantity'].toString())
            : 0,
        reviews: json['reviews'] ?? [],
        location: json['location']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'provider': provider,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'coverImage': coverImage,
      'ratingsQuantity': ratingsQuantity,
      'reviews': reviews,
    };
    if (priceAfterDiscount != null)
      data['priceAfterDiscount'] = priceAfterDiscount;
    if (images != null) data['images'] = images;
    if (ratingsAverage != null) data['ratingsAverage'] = ratingsAverage;
    return data;
  }

  static List<Service> parseServices(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    if (parsed != null && parsed['docs'] != null) {
      final docs = parsed['docs'].cast<Map<String, dynamic>>();
      return docs.map<Service>((json) => Service.fromJson(json)).toList();
    } else {
      throw Exception('Invalid or empty response data');
    }
  }

  static List<Service> filterByCategory(
      List<Service> services, String category) {
    return services
        .where((service) =>
            service.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  static List<Service> fromDynamicList(List<dynamic> dynamicList) {
    return dynamicList.map<Service>((json) => Service.fromJson(json)).toList();
  }
}
