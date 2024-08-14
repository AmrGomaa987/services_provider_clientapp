import 'package:clientphase/models/service_model.dart';
import 'package:clientphase/services/api/service_api.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ServiceListController extends GetxController {
  var isLoading = true.obs;
  var serviceList = [].obs;

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

 fetchServices() async {
  try {
    isLoading(true);

    final response = await ServiceApi().getAllServices();

    if (response.statusCode == 200) {
      final responseData = response.data;

      if (responseData != null) {
        if (responseData["data"]["docs"] is List) {
          final services = responseData["data"]["docs"]
              .map((json) => Service.fromJson(json as Map<String, dynamic>))
              .where((service) => service.category == 'السباكة') // Filter services by category
              .toList();
          serviceList.assignAll(services);
          print(services);
        } else {
          print('Unexpected response format: $responseData');
        }
      } else {
        print('Response data is null');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching service data: $e');
  } finally {
    isLoading(false);
  }
}
}