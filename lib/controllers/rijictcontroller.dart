import 'package:get/get.dart';
import 'package:clientphase/models/booking_model.dart';
import 'package:clientphase/services/api/booking_api.dart';

class RijictBookingController extends GetxController {
  var isLoading = true.obs;
  var completedBookings = <Booking>[].obs;
  var hasConnection = true.obs; 

  @override
  void onInit() {
    super.onInit();
    fetchCompletedBookings();
  }

  Future<void> fetchCompletedBookings() async {
    try {
      isLoading(true);
hasConnection(true);
      final response =
          await BookingApi().getProviderBookingstatusclinet('rejected');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData["data"]["docs"] is List) {
          final bookings = responseData["data"]["docs"] as List<dynamic>;
          completedBookings.assignAll(
              bookings.map((data) => Booking.fromJson(data)).toList());
        } else {
          print('Unexpected response format: $responseData');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      hasConnection(false);

      print('Error fetching completed bookings: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> completeBooking(String bookingId) async {
    try {
      await BookingApi().completeBooking(bookingId: bookingId);
      fetchCompletedBookings(); // Refresh the list of completed bookings
    } catch (e) {
      print('Error completing booking: $e');
    }
  }
}
