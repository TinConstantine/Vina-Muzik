import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/common/state_helper.dart';
import 'package:vina_music_app/common_widget/album_songs_row.dart';
import 'package:vina_music_app/common_widget/artist_album_cell.dart';
import 'package:vina_music_app/common_widget/view_all_section.dart';
import 'package:vina_music_app/page/songs/artists_page/artists_viewmodel.dart';

import '../../../common/color_extension.dart';
import '../../../common/image.dart';
import '../../splash_page/splash_viewmodel.dart';

class ArtistDetailPage extends StatefulWidget {
  const ArtistDetailPage({super.key});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  final artistsViewModel = Get.put(ArtistsViewModel());

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
          "Artist Details",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Image.asset(
                      TImage.imgAlbum1,
                      width: double.maxFinite,
                      height: mediaSize.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  width: double.maxFinite,
                  height: mediaSize.width * 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "History",
                                  style: TextStyle(
                                      color: TColor.primaryText80,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                space8,
                                Text(
                                  "Pop rock, Funk pop, Heavy Metal",
                                  style: TextStyle(
                                      color:
                                          TColor.primaryText.withOpacity(0.74),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      space40,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "4,357",
                                style: TextStyle(
                                    color:
                                    TColor.primaryText.withOpacity(0.9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),

                              Text(
                                "Followers",
                                style: TextStyle(
                                    color:
                                    TColor.primaryText60,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),

                            ],),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "128,980",
                                style: TextStyle(
                                    color:
                                    TColor.primaryText.withOpacity(0.9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Listeners",
                                style: TextStyle(
                                    color: TColor.primaryText60,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),

                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: TColor.primaryG,
                                    begin: Alignment.topCenter,
                                    end: Alignment.center),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            ViewAllSection(title: "Top Albums", onPressed: () {}),
            SizedBox(
              height: 200,
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                scrollDirection: Axis.horizontal,
                itemCount: artistsViewModel.albumsArr.length,
                itemBuilder: (context, index) {
                  var mObj = artistsViewModel.albumsArr[index];
                  return ArtistAlbumCell(
                    mObj: mObj,
                  );
                },
              ),
            ),
            ViewAllSection(title: "Top Songs", onPressed: () {}),
            space12,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              shrinkWrap: true,
              itemCount: artistsViewModel.playedArr.length,
              itemBuilder: (context, index) {
                return AlbumSongsRow(
                    sObj: artistsViewModel.playedArr[index],
                    onPressed: () {},
                    onPressedPlay: () {});
              },
            )
          ],
        ),
      ),
    );
  }
}
