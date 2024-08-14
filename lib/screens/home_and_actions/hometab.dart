import 'dart:io';

import 'package:clientphase/categories/CarouselSlider/carousel.dart';
import 'package:clientphase/chat/inbox.dart';
import 'package:clientphase/controllers/home_catigory_controller.dart';
import 'package:clientphase/controllers/profile_controller.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/provider/bookmark_provider.dart';
import 'package:clientphase/screens/Service_Details_Bookings/AllService.dart';
import 'package:clientphase/screens/accountsetup/editprof.dart';
import 'package:clientphase/screens/home_and_actions/Booking_option_hometap/booking_option.dart';
import 'package:clientphase/screens/home_and_actions/home_icon_section.dart';
import 'package:clientphase/screens/home_and_actions/specialoffers.dart';
import 'package:clientphase/screens/wish.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final CategoryController _categoryController = CategoryController();
 @override
  Widget build(BuildContext context) {
      return WillPopScope(
      onWillPop: () async {
        if (Platform.isIOS) {
          exit(0);
        } else {
          SystemNavigator.pop();
        }
        return true;
      },
    child:
  StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          :  
    Scaffold(
      backgroundColor: Colors.white,
      body: _buildProfileView()
        
    );
  }
  )
    );
  }

Widget _buildProfileView() {
    return ListView(
      children: [
        HeadreHome(),
        SizedBox(height: 20,),
        DescriptionOfTherdPart(
          "عروض مميزه",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return special();
              },
            ));
          },
        ),
        Carousel(),
        DescriptionOfTherdPart(
          " خدمات",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return AllService();
              },
            ));
          },
        ),
        HomeIconSection(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(),
        ),
        
      ],
    );
  }
}
class HeadreHome extends StatefulWidget {
  const HeadreHome({Key? key}) : super(key: key);
  @override
  _HeadreHomeState createState() => _HeadreHomeState();
}

class _HeadreHomeState extends State<HeadreHome> {
 ProfileController profileController= Get.put(ProfileController());
   @override
   void initState() {
    super.initState();
    profileController = Get.put(ProfileController());
    _loadData();
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _loadData();
}

  _loadData() async {
    await _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      await profileController.fetchProfile();
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return _buildProfileView();
      }
    });
  }

  Widget _buildProfileView() {
    final profileData = profileController.profileData.value;
     if (profileData == null) {
    return Center(child: Text('Profile data not available'));
  }
    return  WillPopScope(
      onWillPop: () async {
       
        return true;
      },
      child: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none
              ? const NoConnectionWidget()
              :
           Row(
      children: [
     Padding(
        padding: const EdgeInsets.only(top: 20, right: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => editprof(),
              ),
            );
          },
          child: profileData.profileImage != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(profileData.profileImage!),
                  radius: 30,
                )
              : CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                  child: Icon(Icons.person, color: Colors.white),
                ),
        ),
      ),
    
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: Text(
               profileData.name ?? 'Name not available',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
              overflow: TextOverflow.ellipsis, // Add ellipsis for long names
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                   Get.to(wish());
                },
                icon: Icon(Icons.bookmark, size: 30,color: Color(0xFF7210ff),),
              ),
            ],
          ),
        ),
      ],
    );
  })); }
}
class DescriptionOfTherdPart extends StatelessWidget {
  DescriptionOfTherdPart(this.descrip, {required this.onTap});
  String? descrip;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            "$descrip",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: Text(
              "عرض الجميع",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7210ff),
              ),
            ),
          ),
        )
      ],
    );
  }
}

