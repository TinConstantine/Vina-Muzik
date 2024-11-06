import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/color_extension.dart';
import '../../../common/image.dart';
import '../../splash_page/splash_viewmodel.dart';
import '../albums_page/albums_page.dart';
import '../all_songs_page/all_songs_page.dart';
import '../artists_page/artists_page.dart';
import '../genres_page/genres_page.dart';
import '../playlists_page/playlists_page.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectTab = 0;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(
      () {
        selectTab = tabController.index;
        setState(() {});
      },
    );
    super.initState();
  }

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
          "Songs",
          style: TextStyle(
              color: TColor.primaryText80,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              TImage.imgSearch,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: TColor.primaryText35,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: TabBar(
              isScrollable: true,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 12),
              controller: tabController,
              labelStyle: TextStyle(
                  color: TColor.focus,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(
                  color: TColor.primaryText80,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              indicatorColor: TColor.primary,
              tabs: const [
                Tab(
                  text: "All Songs",
                ),
                Tab(
                  text: "Playlists",
                ),
                Tab(
                  text: "Albums",
                ),
                Tab(
                  text: "Artists",
                ),
                Tab(
                  text: "Genres",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: tabController,
              children: [
                AllSongsPage(),
                PlaylistsPage(),
                AlbumsPage(),
                ArtistsPage(),
                GenresPage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
