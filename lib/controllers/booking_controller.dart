import 'package:clientphase/models/service_model.dart';
import 'package:clientphase/services/api/booking_api.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final BookingApi _bookingApi = BookingApi();
  final Service service;

  final description = ''.obs;
  final Rx<DateTime?> startDate = Rxn<DateTime>(); // Update to allow null
  final Rx<DateTime?> endDate = Rxn<DateTime>(); // Update to allow null
  final price = 0.obs;
  final addressDetails = ''.obs;
  final addressCity = ''.obs;
  final addressPostalCode = ''.obs;
  final addressPhone = ''.obs;
  final isLoading = false.obs;

  BookingController(this.service);

  @override
  void onInit() {
    super.onInit();
    description.value;
    price.value.toDouble();
    addressDetails.value;
    addressCity.value;
    addressPostalCode.value;
    addressPhone.value;
  }

  bool isValidPhoneNumber(String phone) {
    final RegExp phoneRegExp = RegExp(r'^(010|011|012|015)\d{8}$');
    return phoneRegExp.hasMatch(phone);
  }

  Future<void> sendBookingRequest(String serviceId) async {
    // Validation
    if (description.value.isEmpty ||
        price.value == 0 ||
        addressDetails.value.isEmpty ||
        addressCity.value.isEmpty ||
        addressPostalCode.value.isEmpty ||
        addressPhone.value.isEmpty) {
      Get.snackbar('خطأ في الإدخال', 'يرجي ملئ جميع الحقول',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
   else if (description.value.length < 25) {
      Get.snackbar('خطأ في الإدخال', 'الوصف يجب أن يكون على الأقل 25 حرفًا',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    else if (price.value < 50) {
      Get.snackbar('خطأ في الإدخال', 'السعر يجب أن يكون على الأقل 50',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
   else if (!isValidPhoneNumber(addressPhone.value)) {
      Get.snackbar('خطأ في الإدخال',
          'رقم الهاتف يجب أن يبدأ ب او012  010 أو 011 أو 015 ويكون 11 رقمًا',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
   else if (addressPostalCode.value.length != 5) {
      Get.snackbar('خطأ في الإدخال', 'الكود البريدي يجب أن يكون 5 أرقام',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
   else if (startDate.value == null) {
      Get.snackbar('خطأ في الإدخال', 'يرجي ادخال تاريخ البدء',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
   else if (endDate.value == null) {
      Get.snackbar('خطأ في الإدخال', 'يرجي ادخال تاريخ الانتهاء',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
   else if (startDate.value!.isAfter(endDate.value!)) {
      Get.snackbar(
          'خطأ في الإدخال', 'تاريخ البدء يجب أن يكون قبل تاريخ الانتهاء',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    

    isLoading.value = true; // Show loading indicator
    try {
      final Map<String, Object> bookingData = {
        'serviceId': serviceId,
        'description': description.value,
        'startDate': startDate.value!.toIso8601String(),
        'endDate': endDate.value!.toIso8601String(),
        'price': price.value.toDouble(),
        'addressDetails': addressDetails.value,
        'addressCity': addressCity.value,
        'addressPostalCode': addressPostalCode.value,
        'addressPhone': addressPhone.value,
      };
      await _bookingApi.sendBookingRequest(
        bookingData,
        serviceId: serviceId,
        description: description.value,
        startDate: startDate.value!,
        endDate: endDate.value!,
        price: price.value.toDouble(),
        addressDetails: addressDetails.value,
        addressCity: addressCity.value,
        addressPostalCode: addressPostalCode.value,
        addressPhone: addressPhone.value,
      );
      Get.snackbar('طلب الحجز', 'تم إنشاء طلب الحجز بنجاح',
          snackPosition: SnackPosition.BOTTOM);
      // Booking request successful, navigate to success screen or show confirmation message
    } catch (e) {
      Get.snackbar('خطأ في طلب الحجز', 'فشل في إنشاء طلب الحجز حاول ان تجد موعد اخر',
          snackPosition: SnackPosition.BOTTOM);
      print('Error creating booking: $e');
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }
}
