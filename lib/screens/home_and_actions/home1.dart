import 'package:clientphase/categories/CarouselSlider/carousel.dart';
import 'package:clientphase/chat/inbox.dart';
import 'package:clientphase/controllers/profile_controller.dart';
import 'package:clientphase/provider/bookmark_provider.dart';
import 'package:clientphase/screens/Service_Details_Bookings/AllService.dart';
import 'package:clientphase/screens/accountsetup/editprof.dart';
import 'package:clientphase/screens/home_and_actions/Booking_option_hometap/booking_option.dart';
import 'package:clientphase/screens/home_and_actions/home_icon_section.dart';
import 'package:clientphase/screens/home_and_actions/hometab.dart';
import 'package:clientphase/screens/home_and_actions/specialoffers.dart';
import 'package:clientphase/screens/wish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int _currentIndex = 0;
   ProfileController profileController = Get.put(ProfileController());
   @override
   void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WishlistProvider>(context, listen: false).getAll();
      
    });
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
  final List<Widget> _tabs = [
    HomeTab(),
    BookingOptionScreen(),
    Inbox(),
    editprof(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Color(0xFF7210ff),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'رئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'حجوزات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              label: 'محادثة ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'ملف شخصي',
            ),
          ],
        ),
      ),
    );
  }
}




