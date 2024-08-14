import 'package:clientphase/categories/plumbing_container/plumbing_container.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/provider/bookmark_provider.dart';
import 'package:clientphase/screens/profiles/shoppingprofile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class wish extends StatelessWidget {
  const wish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return snapshot.data == ConnectivityResult.none
            ? const NoConnectionWidget()
            : Scaffold(
                appBar: AppBar(
                  title: const Text("الخدمات المحفوظة"),
                ),
                body: Consumer<WishlistProvider>(
                  builder: (context, wishlistProvider, child) {
                    if (wishlistProvider.wishlist.isEmpty) {
                      return Center(
                        child: Text(
                          "لا توجد خدمات محفوظة",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: wishlistProvider.wishlist.length,
                        itemBuilder: (context, index) {
                          final service = wishlistProvider.wishlist[index];
                          return PlumbingContainer(
                            service: service,
                            onTap: () {
                              Get.to(ShoppingProfile(service: service));
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              );
      },
    );
  }
}
