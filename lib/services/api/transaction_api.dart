import 'package:clientphase/services/api/api.dart';
import 'package:dio/dio.dart';

class TransactionApi {
  final Dio _dio = DioClient().dio;

  Future<Response> getAllTransactions() async{
     try {
      return await _dio.get('/v1/transaction');
    } catch (e) {
      throw Exception("Failed to fetch transactions | error: $e");
    }
  }

// provider only
  Future<Response> cashPayment ({required bookingId})async{
     try {
      return await _dio.post('/v1/transaction/booking/cash/$bookingId');
    } catch (e) {
      throw Exception("Failed to create cash payment | error: $e");
    }
  }

  // client only
    Future<Response> cardPayment ({required bookingId})async{
     try {
      return await _dio.post('/v1/transaction/payment-sheet/$bookingId');
    } catch (e) {
      throw Exception("Failed to create card payment | error: $e");
    }
  }
}