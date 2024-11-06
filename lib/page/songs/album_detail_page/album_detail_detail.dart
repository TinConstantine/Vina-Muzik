import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/common/state_helper.dart';
import 'package:vina_music_app/common_widget/album_songs_row.dart';
import 'package:vina_music_app/page/songs/albums_page/albums_viewmodel.dart';

import '../../../common/color_extension.dart';
import '../../../common/image.dart';
import '../../splash_page/splash_viewmodel.dart';

class AlbumDetailPage extends StatefulWidget {
  const AlbumDetailPage({super.key});

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  final albumViewModel = Get.put(AlbumViewModel());
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
            "Album Details",
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                TImage.imgAlbum1,
                                width: 100,
                                height: 100,
                              ),
                              space16,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "by Michael Jackson",
                                      style: TextStyle(
                                          color: TColor.primaryText.withOpacity(
                                              0.74),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    space8,
                                    Text(
                                      "1996   |   18 songs   |   64min",
                                      style: TextStyle(
                                          color: TColor.primaryText.withOpacity(
                                              0.74),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          space16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
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
                                  child: Text("Play", style: TextStyle(
                                      color: TColor.primaryText,
                                      fontWeight: FontWeight.w600),),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 140,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: TColor.primaryText, width: 1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text("Add to Favorites",
                                    style: TextStyle(color: TColor.primaryText,
                                        fontWeight: FontWeight.w600),),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: TColor.primaryText, width: 1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text("Share", style: TextStyle(
                                      color: TColor.primaryText,
                                      fontWeight: FontWeight.w600),),
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                ),
                space12,
                ListView.builder(physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: albumViewModel.playedArr.length,
                    itemBuilder: (context, index) {
                        return AlbumSongsRow(sObj: albumViewModel.playedArr[index], onPressed: (){}, onPressedPlay: (){});
                    },)
              ],
            ),
          ),
        ));
  }
}
