import 'dart:ffi';
import 'package:clientphase/services/api/api.dart';
import 'package:dio/dio.dart';

class BookingApi {
  final Dio _dio = DioClient().dio;

// client or provider
  Future<Response> getBookingById({required String id}) async {
    try {
      return await _dio.get("/v1/booking/$id");
    } catch (e) {
      throw Exception("Failed to get booking by id $id | error: $e");
    }
  }

// client only
  Future<Response> getMyBooking() async {
    try {
      return await _dio.get("/v1/booking/myBooking");
    } catch (e) {
      throw Exception("Failed to get my booking | error: $e");
    }
  }

// provider only
  Future<Response> getProviderBooking() async {
    try {
      return await _dio.get("/v1/booking/providerBooking");
    } catch (e) {
      throw Exception("Failed to get provider booking | error: $e");
    }
  }

// client only
  Future<Response> sendBookingRequest(Map<String, Object> booking, 
      {required String serviceId,
      required String description,
      required DateTime startDate,
      required DateTime endDate,
      required double price,
      required String addressDetails,
      required String addressCity,
      required String addressPostalCode,
      required String addressPhone}) async {
    try {
      Map<String, dynamic> address = {
        'details': addressDetails,
        'phone': addressPhone,
        'city': addressCity,
        "postalCode": addressPostalCode,
      };

      Map<String, dynamic> booking = {
        'serviceId': serviceId,
        'description': description,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'price': price,
        'address': address,
      };

      return await _dio.post("/v1/booking/booking-request", data: booking);
    } catch (e) {
      throw Exception("Failed to send booking request | error: $e");
    }
  }

// provider only
  Future<Response> sendBookingResponse(
      {required String bookingId,
      required bool response,
      String? rejectReason}) async {
    try {
      Map<String, dynamic> booking = {
        "response": response ? "accepted" : "rejected",
      };

      if (rejectReason != null && rejectReason.isNotEmpty) {
        booking["rejectReason"] = rejectReason;
      }

      return await _dio.post("/v1/booking/booking-response/$bookingId",
          data: booking);
    } catch (e) {
      throw Exception("Failed to send booking response | error: $e");
    }
  }

// client or provider
  Future<Response> cancleBooking(
      {required String bookingId, String? cancleReason}) async {
    try {
      Map<String, dynamic> booking = {
        "cancleReason": cancleReason,
      };

      return await _dio.put("/v1/booking/cancle-booking/$bookingId",
          data: booking);
    } catch (e) {
      throw Exception("Failed to cancle booking  | error: $e");
    }
  }

// client or provider must be paid to mark as completed
  Future<Response> completeBooking({required String bookingId}) async {
    try {
      return await _dio.put("/v1/booking/complete-booking/$bookingId");
    } catch (e) {
      throw Exception("Failed to complete booking  | error: $e");
    }
  }
 Future<Response> getProviderBookingstatusclinet(String status) async {
    try {
      return await _dio.get("/v1/booking/myBooking?status=$status");
    } catch (e) {
      throw Exception("Failed to get provider booking | error: $e");
    }
  }
}
