import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:clientphase/models/service_model.dart';
import 'package:clientphase/services/api/service_api.dart';

class ServiceListControllerShopping extends GetxController {
  var isLoading = true.obs;
  var serviceList = <Service>[].obs;
  final String id;

  ServiceListControllerShopping(this.id);

  @override
  void onInit() {
    super.onInit();
    fetchServicesByCategory(id);
  }

  Future<void> fetchServicesByCategory(String id) async {
  try {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      isLoading(true);
    });
    final services = await ServiceApi().getServicesByCategoryId(id);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      serviceList.assignAll(services);
    });
  } catch (e) {
    print('Error fetching service data: $e');
  } finally {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      isLoading(false);
    });
  }
}

}
