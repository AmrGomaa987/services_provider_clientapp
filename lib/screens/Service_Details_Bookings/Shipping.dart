import 'dart:async';
import 'package:clientphase/noconn.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clientphase/controllers/service_list_controller_shopping.dart';
import 'package:clientphase/categories/plumbing_container/plumbing_container.dart';
import 'package:clientphase/models/service_model.dart';
import 'package:clientphase/screens/home_and_actions/home1.dart';
import 'package:clientphase/screens/profiles/shoppingprofile.dart';
import 'package:clientphase/screens/wish.dart';

class ShippingService extends StatefulWidget {
  const ShippingService({Key? key, required this.id, required this.nameserv})
      : super(key: key);

  final String id;
  final String nameserv;

  @override
  _ShippingServiceState createState() => _ShippingServiceState();
}

class _ShippingServiceState extends State<ShippingService> {
  late ServiceListControllerShopping serviceController;
  late List<Service> _services = [];
  late List<Service> _filteredServices = [];
  bool _isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    serviceController = Get.put(ServiceListControllerShopping(widget.id));
    _fetchServices();
    // Set up timer for automatic refresh
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _fetchServices();
    });
  }

  @override
  void dispose() {
    Get.delete<ServiceListControllerShopping>();
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchServices() async {
    await serviceController.fetchServicesByCategory(widget.id);
    setState(() {
      _services = serviceController.serviceList;
      _filteredServices = serviceController.serviceList;
      _isLoading = false;
    });
  }

  void _filterServices(String keyword) {
    setState(() {
      _filteredServices = _services
          .where((service) =>
              service.provider["name"]
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              service.location.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  Future<void> _refresh() async {
    await _fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (serviceController.isLoading.value) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return 
         StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              widget.nameserv,
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () {
                Get.to(Home1());
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'ابحث عن مقدم الخدمة أو عنوان الخدمة',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            prefixIcon: Icon(Icons.search, color: Color(0xFF7210ff)),
                          ),
                          cursorColor: Color(0xFF7210ff),
                          style: TextStyle(fontSize: 10),
                          onChanged: _filterServices,
                        ),
                      ),
                      Expanded(
                        child: _filteredServices.isEmpty
                            ? Center(
                                child: Text(
                                  "لا يوجد خدمات",
                                  style: TextStyle(fontSize: 24),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _filteredServices.length,
                                itemBuilder: (context, index) {
                                  final service = _filteredServices[index];
                                  return PlumbingContainer(
                                    service: service,
                                    onTap: () {
                                      Get.to(ShoppingProfile(service: service));
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color(0xFF7210ff),
            foregroundColor: Colors.white,
            onPressed: () {
              Get.to(wish());
            },
            label: Text('الخدمات المحفوظة'),
          ),
        );
      });}
    });
  }
}
