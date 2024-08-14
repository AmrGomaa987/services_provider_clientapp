
import 'package:clientphase/services/api/wishlist_api.dart';
import 'package:flutter/material.dart';
import 'package:clientphase/models/service_model.dart';
class WishlistProvider extends ChangeNotifier {
  List<Service> _wishlist = [];
  final WishlistApi _api = WishlistApi();

  List<Service> get wishlist => _wishlist;

  // Method to get all wishlist items
  Future<void> getAll() async {
    // Your API call to get all wishlist items goes here
    final res = await _api.getMyWishlist();

    // After getting the wishlist items, update the local _wishlist variable
    _wishlist = Service.fromDynamicList(
        res.data["data"]["wishlist"]); // Assign the fetched wishlist items here
    notifyListeners();
  }

  Future<void> add(String serviceId) async {
    await _api.addServiceToWishlist(serviceId: serviceId);
    getAll();
  }

  Future<void> remove(String serviceId) async {
    await _api.removeServiceFromWishlist(serviceId: serviceId);
    getAll();
  }

  bool isInWishList(String serviceId) {
    final index = _wishlist.indexWhere((service) => service.id == serviceId);

    return index > -1 ? true : false;
  }
}
