
import 'package:flutter/material.dart';
import 'package:vina_music_app/common_widget/my_playlists_cell.dart';
import 'package:vina_music_app/common_widget/view_all_section.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/page/songs/playlists_page/playlists_viewmodel.dart';

import '../../../common/color_extension.dart';
import '../../../common/image.dart';
import '../../../common_widget/playlist_songs_cell.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({super.key});

  @override
  State<PlaylistsPage> createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage> {
  final playlistsViewModel = Get.put(PlaylistsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.floatingActionButtonColor,

        onPressed: (){},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Image.asset(TImage.imgAdd),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ViewAllSection(title: "My Playlists", onPressed: () {}),
            Obx(() =>
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: playlistsViewModel.playlistArr.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0), itemBuilder: (context, index) {
                          var pObj = playlistsViewModel.playlistArr[index];
                          return MyPlaylistSongsCell(onPressedPlay: (){},onPressed: (){},sObj: pObj,);
                        },),),
            SizedBox(
              height: 152,
              child: Obx(
                    () {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 4),
                    itemCount: playlistsViewModel.myPlaylistArr.length,
                    itemBuilder: (context, index) {
                      var sObj = playlistsViewModel.myPlaylistArr[index];
                      return MyPlaylistsCell(
                          sObj: sObj, onPressed: () {}, onPressedPlay: () {});
                    },
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
