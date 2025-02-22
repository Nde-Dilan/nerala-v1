import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/music/source/audio_service.dart';
import 'package:other_screens/presentation/chat/chat_page.dart';


//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:other_screens/firebase_options.dart';
import 'package:other_screens/presentation/dictionary/pages/dictionary.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:other_screens/presentation/pages/landing_page.dart';
import 'package:other_screens/presentation/settings/pages/settings_page.dart'; 
import 'package:other_screens/service_locator.dart';

//logging
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Firebase initialization first
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // Dependencies next
    await initializeDependencies();

    // Configure logging
    if (kDebugMode) {
      
      Logger.root.level = Level.FINE;
    }

    Logger.root.onRecord.listen((record) {
      debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    });

    // System UI configuration
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );

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
  } catch (e) {
    debugPrint('Initialization error: $e');
  }
}

Logger _log = Logger('main.dart');

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioService.pause();
    } else if (state == AppLifecycleState.resumed) {
      _audioService.play();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerala',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  ChatPage()
        
       
    );
  }
}
