import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/page/main_tab/main_tab_page.dart';

import '../home/home_page.dart';
class SplashViewmodel extends GetxController{
  final drawerKey = GlobalKey<ScaffoldState>();
    void loadView ()async{
      await Future.delayed(const Duration(seconds: 3));
      Get.to(()=> const MainTabPage());
    }

    void openDrawer(){
      drawerKey.currentState?.openDrawer();
    }
    void closeDrawer(){
      drawerKey.currentState?.closeDrawer();

    }
}