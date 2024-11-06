import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/audio_helpers/page_manager.dart';
import 'package:vina_music_app/audio_helpers/service_locator.dart';
import 'package:vina_music_app/page/splash_page/splash_page.dart';
import 'common/color_extension.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getIt<PageManager>().init();
    super.initState();
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vinahouse Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Circular std",
        scaffoldBackgroundColor: TColor.bg,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: TColor.primaryText,
          displayColor: TColor.primaryText,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

