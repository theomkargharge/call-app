import 'package:call_app/contacts_screen/binding/contact_screen_binding.dart';
import 'package:call_app/contacts_screen/contacts_screen.dart';
import 'package:call_app/dialer_pad/binding/dialerpad_binding.dart';
import 'package:call_app/dialer_pad/dialer_pad.dart';
import 'package:call_app/navbar/binding/nav_bar_binding.dart';
import 'package:call_app/navbar/nav_bar.dart';
import 'package:call_app/splash_screen/binding/splash_screen_binding.dart';
import 'package:call_app/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Call App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          binding: SplashScreenBinding(),
        ),
        GetPage(
          name: '/navbar',
          page: () => Navbar(),
          binding: NavBarBinding(),
        ),
        GetPage(
          name: '/dialer',
          page: () => DialerPad(),
          binding: DialerPadBinding(),
        ),
        GetPage(
          name: '/contact',
          page: () => ContactsScreen(),
          binding: ContactScreenBinding(),
        ),
      ],
      initialBinding: SplashScreenBinding(),
    );
  }
}
