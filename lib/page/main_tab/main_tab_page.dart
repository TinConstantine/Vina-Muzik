import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/common/image.dart';
import 'package:vina_music_app/common/state_helper.dart';
import 'package:vina_music_app/common_widget/mini_player.dart';
import 'package:vina_music_app/page/home/home_page.dart';
import 'package:vina_music_app/page/settings/settings_page.dart';
import 'package:vina_music_app/page/songs/songs_page/songs_page.dart';
import 'package:vina_music_app/page/splash_page/splash_viewmodel.dart';

import '../../common/color_extension.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedTab = 0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(
      () {
        setState(() {
          selectedTab = tabController.index;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Get.find<SplashViewmodel>().drawerKey,
        drawer: Drawer(
          backgroundColor: TColor.drawerBg,
          child: ListView(
            children: [
              SizedBox(
                height: 210,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: TColor.primaryText.withOpacity(0.03),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        TImage.imgLogoApp,
                        width: mediaSize.width * 0.18,
                      ),
                      space20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '328\nSongs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: TColor.textDrawer),
                          ),
                          Text(
                            "87\nArtists",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: TColor.textDrawer),
                          ),
                          Text(
                            '328\nSongs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: TColor.textDrawer),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              itemDrawer(image: TImage.imgTheme, title: "Themes", onTap: null),
              Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),
              itemDrawer(image: TImage.imgRingtone, title: "Ringtone Cutter", onTap: null),
              Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),
              itemDrawer(image: TImage.imgSleepTimer, title: "Sleep Timer", onTap: null),
              Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),
              itemDrawer(image: TImage.imgEqualizer, title: "Equalizer", onTap: null),
              Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),
              itemDrawer(image: TImage.imgDriverMode, title: "Driver Mode", onTap: null),
              Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),
              itemDrawer(image: TImage.imgHiddenFolders, title: "Hidden Folders", onTap: null),
              Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),
              itemDrawer(image: TImage.imgScanMedia, title: "Scan Media", onTap: null),
              Divider(color: TColor.primaryText.withOpacity(0.07), indent: 56,),

            ],
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            TabBarView(
              controller: tabController,
              children: const [
                 HomePage(),
                 SongsPage(),
                 SettingsPage(),
              ],
            ),
            MiniPlayer(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: TColor.bg, boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              offset: Offset(0, -3),
            )
          ]),
          child: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: TabBar(
                controller: tabController,
                indicatorColor: Colors.transparent,
                indicatorWeight: 1,
                labelColor: TColor.primary,
                labelStyle: const TextStyle(fontSize: 10),
                unselectedLabelColor: TColor.primaryText28,
                unselectedLabelStyle: const TextStyle(fontSize: 10),
                tabs: [
                  Tab(
                    text: "Home",
                    icon: Image.asset(
                      selectedTab == 0
                          ? TImage.imgHomeTabActive
                          : TImage.imgHomeTabDeactivate,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Tab(
                    text: "Songs",
                    icon: Image.asset(
                      selectedTab == 1
                          ? TImage.imgSongTabActive
                          : TImage.imgSongTabDeactivate,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Tab(
                    text: "Settings",
                    icon: Image.asset(
                      selectedTab == 2
                          ? TImage.imgSettingsTabActive
                          : TImage.imgSettingsTabDeactivate,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ]),
          ),
        ));
  }
}
Widget itemDrawer({required String title, required String image, required VoidCallback? onTap}){
  return ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    leading: Image.asset(image, width: 25, height: 25, fit: BoxFit.contain,),
    title: Text(title, style: TextStyle(color: TColor.primaryText.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.w600 ),),
  );
}
