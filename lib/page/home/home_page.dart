import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/common/image.dart';
import 'package:vina_music_app/common_widget/recommended_cell.dart';
import 'package:vina_music_app/common_widget/title_selection.dart';
import 'package:vina_music_app/common_widget/view_all_section.dart';
import 'package:vina_music_app/page/home/home_page_viewmodel.dart';
import 'package:vina_music_app/page/splash_page/splash_viewmodel.dart';

import '../../common/color_extension.dart';
import '../../common_widget/playlist_cell.dart';
import '../../common_widget/songs_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageViewmodel = Get.put(HomePageViewmodel());

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
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xff292E4B),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: homePageViewmodel.txtSearch.value,
                  decoration: InputDecoration(
                      prefixIcon: Container(
                          margin: const EdgeInsets.only(left: 16),
                          width: 36,
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            TImage.imgSearch,
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            color: TColor.primaryText28,
                          )),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 16),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: "Search album song",
                      hintStyle: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 13,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleSelection(title: "Hot Recommend"),
            SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                scrollDirection: Axis.horizontal,
                itemCount: homePageViewmodel.hostRecommendedArr.length,
                itemBuilder: (context, index) {
                  var mObj = homePageViewmodel.hostRecommendedArr[index];
                  return RecommendedCell(
                    mObj: mObj,
                  );
                },
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            ViewAllSection(title: "Playlist", onPressed: (){}),
            SizedBox(
              height: 170,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                scrollDirection: Axis.horizontal,
                itemCount: homePageViewmodel.playListArr.length,
                itemBuilder: (context, index) {
                  var mObj = homePageViewmodel.playListArr[index];
                  return PlaylistCell(
                    mObj: mObj,
                  );
                },
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            ViewAllSection(title: "Recently Played", onPressed: (){}),
            SizedBox(
              height: 200,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: homePageViewmodel.recentlyPlayedArr.length,
                itemBuilder: (context, index) {
                  var mObj = homePageViewmodel.recentlyPlayedArr[index];
                  return SongsRow(
                    sObj: mObj,
                    onPressed: (){},
                    onPressedPlay: (){},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
