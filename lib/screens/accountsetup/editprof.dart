import 'package:clientphase/noconn.dart';
import 'package:clientphase/screens/home_and_actions/home1.dart';
import 'package:clientphase/screens/letsin/letsyou.dart';
import 'package:clientphase/screens/profiles/fullscreean.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:clientphase/controllers/profile_controller.dart';
import 'package:clientphase/screens/accountsetup/profileprovider.dart';
import 'package:clientphase/network/local/cach_helper.dart';
import 'package:clientphase/screens/letsin/login.dart';
import 'package:get/get_core/src/get_main.dart';

class editprof extends StatefulWidget {
  const editprof({Key? key}) : super(key: key);

  @override
  _EditProfState createState() => _EditProfState();
}

class _EditProfState extends State<editprof> {
  late ProfileController profileController;

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

  Future<void> _refreshProfile() async {
    setState(() {});
    await _fetchProfile();
    setState(() {});
  }

  Future<void> _handleRefresh() async {
    await _refreshProfile();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return snapshot.data == ConnectivityResult.none
            ? const NoConnectionWidget()
            :  WillPopScope(
      onWillPop: () async {
        if (Platform.isIOS) {
          exit(0);
        } else {
          SystemNavigator.pop();
        }
        return true;
      },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Obx(() {
                    if (profileController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return _buildProfileView();
                    }
                  }),
                ),
              );
      },
    );
  }

  Widget _buildProfileView() {
    final profileData = profileController.profileData.value;
    if (profileData == null) {
      return Center(child: Text('Profile data not available'));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('الصفحة الشخصيه'),
        leading: Container(),
        foregroundColor: Colors.black, // Set app bar foreground color
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => Profile(),
        child: Consumer<Profile>(
          builder: (context, provider, child) {
            return GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! > 0) {
                  _handleRefresh();
                }
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (profileData.profileImage != null &&
                                        profileData.profileImage.toString().isNotEmpty) {
                                      Get.to(() => FullScreenImage(
                                            imageUrls: [profileData.profileImage.toString()],
                                            initialIndex: 0,
                                          ));
                                    }
                                  },
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: provider.image != null
                                          ? Image.file(
                                              File(provider.image!.path),
                                              fit: BoxFit.cover,
                                            )
                                          : (profileData.profileImage != null &&
                                                  profileData.profileImage.toString().isNotEmpty
                                              ? Image.network(
                                                  profileData.profileImage.toString(),
                                                  loadingBuilder: (context, child, loadingProgress) {
                                                    if (loadingProgress == null) return child;
                                                    return Center(child: CircularProgressIndicator());
                                                  },
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Icon(Icons.error_outline, color: Colors.black);
                                                  },
                                                )
                                              : Icon(Icons.person, size: 35)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                provider.pickImage(context);
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.black,
                                child: Icon(Icons.add, size: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            profileData.email,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            provider.showUserName(context, profileData.name);
                          },
                          child: Resubale(
                            title: 'اسم المستخدم',
                            value: profileData.name ?? 'xxxxx',
                            iconData: Icons.person_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.showUserbio(context, profileData.bio ?? '');
                          },
                          child: Resubale(
                            title: 'الكنية',
                            value: profileData.bio ?? 'لا يوجد',
                            iconData: Icons.article_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.showPassword(context);
                          },
                          child: Resubale(
                            title: 'كلمة المرور',
                            value: 'xxxxxxxxx',
                            iconData: Icons.password_outlined,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: TextButton(
                            onPressed: () async {
                try {
                  bool? token = await CacheHelper.removeData(key: 'token');
                  if (token) {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => Login()));
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Letsyou()), (route)=>false);
                                      }
                } catch (e) {
                  print('error when sign out = ]]]]]]]]]]]]]$e');
                }
              },
                            child: Text(
                              "تسجيل الخروج",
                              style: TextStyle(
                                color: Color(0xFF7210ff),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Resubale extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const Resubale({Key? key, required this.title, required this.iconData, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: Icon(iconData, color: Colors.black),
        ),
        Divider(color: Colors.black.withOpacity(0.4)),
      ],
    );
  }
}
