import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/common/image.dart';
import 'package:vina_music_app/common/state_helper.dart';
import 'package:vina_music_app/page/splash_page/splash_viewmodel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashViewmodel = Get.put(SplashViewmodel());

  @override
  void initState() {
    splashViewmodel.loadView();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(TImage.imgLogoApp, width: mediaSize.width * 0.3, ),
      ),
    );
  }
}
