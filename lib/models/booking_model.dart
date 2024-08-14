import 'dart:convert';
import 'package:clientphase/models/user_model.dart';

class Booking {
  final String id;
  final String serviceId;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final BookingAddress address;
  final String status;
  final String? rejectReason;
  final User user; // Add user object
  final User provider;
  final String service;
  final bool ispaid;

  Booking({
    required this.id,
    required this.serviceId,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.address,
    required this.status,
    required this.user,
    required this.provider,
    required this.service,
    required this.ispaid,
    this.rejectReason,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    // Parse the startDate and endDate and strip out the time components
    DateTime startDate = DateTime.parse(json['startDate']).toLocal();
    startDate = DateTime(startDate.year, startDate.month, startDate.day);

    DateTime endDate = DateTime.parse(json['endDate']).toLocal();
    endDate = DateTime(endDate.year, endDate.month, endDate.day);

    return Booking(
      id: json["_id"] ?? "",
      serviceId: json['serviceId'] ?? "",
      description: json['description'] ?? "",
      startDate: startDate,
      endDate: endDate,
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
      address: BookingAddress.fromJson(json['address'] ?? {}),
      status: json['status'] ?? "",
      rejectReason: json['rejectReason'],
      ispaid: json['isPaid'],
      user: User.fromJson(json['user']),
      provider: User.fromJson(json['provider']),
      service: json['service']['title']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'serviceId': serviceId,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'price': price,
      'address': address.toJson(),
      'status': status,
      'user': user.toJson(),
      'provider': provider.toJson(),
      'service': service,
      'isPaid': ispaid,
    };
    if (rejectReason != null) data['rejectReason'] = rejectReason;
    return data;
  }

  static List<Booking> parseBookings(dynamic responseBody) {
    final Map<String, dynamic> parsed = responseBody;
    if (parsed.containsKey('data') && parsed['data'].containsKey('docs')) {
      final List<dynamic> docs = parsed['data']['docs'];
      return docs.map<Booking>((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Invalid or empty response data');
    }
  }
}

class BookingAddress {
  final String details;
  final String phone;
  final String city;
  final String postalCode;

  BookingAddress({
    required this.details,
    required this.phone,
    required this.city,
    required this.postalCode,
  });

  factory BookingAddress.fromJson(Map<String, dynamic> json) {
    return BookingAddress(
      details: json['details'] ?? "",
      phone: json['phone'] ?? "",
      city: json['city'] ?? "",
      postalCode: json['postalCode'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'details': details,
      'phone': phone,
      'city': city,
      'postalCode': postalCode,
    };
  }
}
