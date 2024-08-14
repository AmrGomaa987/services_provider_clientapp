import 'package:get/get.dart';
import 'package:clientphase/models/booking_model.dart';
import 'package:clientphase/services/api/booking_api.dart';

class MyClinetBookingController extends GetxController {
  var isLoading = true.obs;
  var myBookings = <Booking>[].obs;
  var hasConnection = true.obs; 

  @override
  void onInit() {
    super.onInit();
    fetchPendingBookings();
  }

  Future<void> fetchPendingBookings() async {
    try {
      isLoading(true);
  hasConnection(true);

      final response = await BookingApi().getProviderBookingstatusclinet('pending');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData["data"]["docs"] is List) {
          final bookings = responseData["data"]["docs"] as List<dynamic>;
          myBookings.assignAll(
              bookings.map((data) => Booking.fromJson(data)).toList());
        } else {
          print('Unexpected response format: $responseData');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
        hasConnection(false);

      print('Error fetching pending bookings: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      await BookingApi().cancleBooking(bookingId: bookingId);
      // Refresh my bookings after cancellation
      fetchPendingBookings(); // Refresh the list of pending bookings
    } catch (e) {
      print('Error cancelling booking: $e');
    }
  }
}
