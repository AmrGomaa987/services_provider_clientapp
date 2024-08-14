import 'package:clientphase/controllers/profile_controller.dart';
import 'package:clientphase/controllers/reviewcontroller.dart';
import 'package:clientphase/controllers/updatereview.dart';
import 'package:clientphase/firebase_options.dart';
import 'package:clientphase/models/review_model.dart';
import 'package:clientphase/network/local/cach_helper.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/provider/bookmark_provider.dart';
import 'package:clientphase/provider/review.dart';
import 'package:clientphase/provider/updatereview.dart';
import 'package:clientphase/screens/accountsetup/profileprovider.dart';
import 'package:clientphase/screens/splashScreen/splash_screen.dart';
import 'package:clientphase/services/api/wishlist_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:clientphase/controllers/image_controller.dart'; // Import your ImageController
import 'package:get/get.dart';

// Import your main screen
void main() async {
   WishlistApi wishlistApi = WishlistApi();
  
  // Set the auth token
  wishlistApi.setAuthToken('your_valid_token');
  

  // firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final ProfileController profileController = Get.put(ProfileController());
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Get.put(ImageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => Profile()),
        ChangeNotifierProvider(create: (context) => ReviewControllerr()),
       // ChangeNotifierProvider(create: (context) => UpdateReviewControllerr())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Cairo'),
        locale: Locale('ar', 'AE'), // Set default locale to Arabic
        fallbackLocale: Locale('ar', 'AE'), // Fallback to Arabic
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        home: 
        StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          :
          SplashPage();}
      
      ),)
    );
  }
}