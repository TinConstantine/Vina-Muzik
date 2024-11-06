import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/audio_helpers/player_invoke.dart';
import 'package:vina_music_app/common_widget/all_song_row.dart';
import 'package:vina_music_app/page/main_player/main_player_page/main_player_page.dart';
import 'package:vina_music_app/page/songs/all_songs_page/all_songs_viewmodel.dart';

class AllSongsPage extends StatefulWidget {
  const AllSongsPage({super.key});

  @override
  State<AllSongsPage> createState() => _AllSongsPageState();
}

class _AllSongsPageState extends State<AllSongsPage> {
  final allSongViewModel = Get.put(AllSongsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            itemCount: allSongViewModel.allList.length,
            itemBuilder: (context, index) {
              var sObj = allSongViewModel.allList[index];
              return AllSongsRow(
                  sObj: sObj, onPressed: () {}, onPressedPlay: () {
                    // Get.to(const MainPlayerPage());
                playerPlayProcessDebounce(allSongViewModel.allList.map((sObj) => {
                  'id': sObj["id"].toString(),
                  'title': sObj["name"].toString(),
                  'artist': sObj["artists"].toString(),
                  'album': sObj["album"].toString(),
                  'genre': sObj["language"].toString(),
                  'image': sObj["image"].toString(),
                  'url': sObj["downloadUrl"].toString(),
                  'user_id': sObj["artistsId"].toString(),
                  'user_name': sObj["artists"].toString(),
                }).toList() , index);
              });
            },
          );
        },
      ),
    );
  }
}
