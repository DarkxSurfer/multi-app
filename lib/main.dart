import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:media_kit/media_kit.dart';
import 'package:multi_app/Home/home_screen.dart';
import 'package:multi_app/firebase_options.dart';
import 'package:multi_app/localization/languages.dart';
import 'package:multi_app/stripe/payment_service.dart';
import 'package:multi_app/theme/theme_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();
  MediaKit.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey =
      'pk_test_51PxQxmJJK1h5n0shSnV82WeDJ3YihnBiFAUR65gFhNeRBySsCXAmlpxdWQ3FsS0glrKi8KdkFzy6Rn5qBT4AEdmH00aMbo8fiA';

  await dotenv.load(fileName: "assets/.env");
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => PaymentService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp for localization
      debugShowCheckedModeBanner: false,
      translations: Languages(), // Add your translations class
      locale: const Locale('en', 'US'), // Set the device locale
      fallbackLocale: const Locale('en', 'US'), // Fallback locale

      theme: ThemeData(
        brightness: Provider.of<ThemeProvider>(context).isDarkMode
            ? Brightness.dark
            : Brightness.light,
      ),

      home: const HomeScreen(),
    );
  }
}
