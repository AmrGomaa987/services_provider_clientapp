import 'package:clientphase/controllers/booking_controller.dart';
import 'package:clientphase/models/service_model.dart';
import 'package:clientphase/noconn.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingVieww extends StatelessWidget {
  final String serviceId;
  final Service service;
  final BookingController controller;

  BookingVieww({required this.serviceId, required this.service})
      : controller = Get.put(BookingController(service));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
          Scaffold(
      appBar: AppBar(
        title: Text('عرض الحجز'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(
                labelText: "الوصف",
                prefixIcon: Icons.description,
                onChanged: (value) => controller.description.value = value,
              ),
              SizedBox(height: 20),
              customTextField(
                labelText: "السعر",
                prefixIcon: Icons.price_change,
                onChanged: (value) {
                  try {
                    controller.price.value = double.parse(value).toInt();
                  } catch (e) {
                    // controller.price.value = 0; // or handle appropriately
                    // Get.snackbar('خطأ في الإدخال', 'الرجاء إدخال سعر صحيح',
                    //     snackPosition: SnackPosition.BOTTOM);
                  }
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              customTextField(
                labelText: "العنوان",
                prefixIcon: Icons.location_on,
                onChanged: (value) => controller.addressDetails.value = value,
              ),
              SizedBox(height: 20),
              customTextField(
                labelText: "المدينة",
                prefixIcon: Icons.location_city,
                onChanged: (value) => controller.addressCity.value = value,
              ),
              SizedBox(height: 20),
              customTextField(
                labelText: "الكود البريدى",
                prefixIcon: Icons.maps_home_work_rounded,
                onChanged: (value) =>
                    controller.addressPostalCode.value = value,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              customTextField(
                labelText: "رقم الهاتف",
                prefixIcon: Icons.phone,
                onChanged: (value) => controller.addressPhone.value = value,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              Text('تاريخ البدء'),
              Obx(() => Text(controller.startDate.value == null
                  ? 'لم يتم اختيار تاريخ البدء'
                  : formatDate(controller.startDate.value!))),
              ElevatedButton(
                onPressed: () => _selectDate(context, true),
                child: Text(
                  'حدد تاريخ البدء',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF7210ff)),
                ),
              ),
              SizedBox(height: 20),
              Text('تاريخ الانتهاء'),
              Obx(() => Text(controller.endDate.value == null
                  ? 'لم يتم اختيار تاريخ الانتهاء'
                  : formatDate(controller.endDate.value!))),
              ElevatedButton(
                onPressed: () => _selectDate(context, false),
                child: Text(
                  'حدد تاريخ الانتهاء',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF7210ff)),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => controller.sendBookingRequest(serviceId),
                  child: Text('إنشاء الحجز',
                      style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF7210ff)),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
        });}

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (controller.startDate.value ?? DateTime.now())
          : (controller.endDate.value ?? DateTime.now()),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      if (isStartDate) {
        controller.startDate.value = pickedDate;
      } else {
        controller.endDate.value = pickedDate;
      }
    }
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}

Widget customTextField({
  required String labelText,
  required IconData prefixIcon,
  required Function(String) onChanged,
  TextInputType? keyboardType,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 1, right: 1),
    child: TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 12.0),
      decoration: InputDecoration(
        labelText: labelText,
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF7210ff))),
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        filled: true,
        fillColor: Color.fromARGB(248, 247, 247, 248),
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF7210ff),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}
