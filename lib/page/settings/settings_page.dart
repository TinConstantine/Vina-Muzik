import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/color_extension.dart';
import '../../common/image.dart';
import '../main_tab/main_tab_page.dart';
import '../splash_page/splash_viewmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.find<SplashViewmodel>().openDrawer();
            },
            icon: Image.asset(
              TImage.imgMenu,
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            )),
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
              color: TColor.primaryText80,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          itemDrawer(image: TImage.imgDisplay, title: "Display", onTap: null),
          Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),

          itemDrawer(image: TImage.imgAudio, title: "Audio", onTap: null),
          Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),

          itemDrawer(image: TImage.imgHeadset, title: "Headset", onTap: null),
          Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),

          itemDrawer(image: TImage.imgLockScreen, title: "Lock Screen", onTap: null),
          Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),

          itemDrawer(image: TImage.imgAdvanced, title: "Advanced", onTap: null),
          Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),

          itemDrawer(image: TImage.imgOther, title: "Other", onTap: null),
        ],
      )
    );
  }
}
