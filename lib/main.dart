import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:other_screens/common/constants.dart';

import 'package:other_screens/presentation/onboarding/pages/daily_goal_page.dart';
import 'package:other_screens/presentation/pages/landing_page.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:other_screens/firebase_options.dart';
import 'package:other_screens/service_locator.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();

  WidgetsFlutterBinding.ensureInitialized();

   SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );


// Set color of status bar to scaffold bg
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: systemChrome.withAlpha(0),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: systemChrome,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Lock device orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(const MyApp()),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
