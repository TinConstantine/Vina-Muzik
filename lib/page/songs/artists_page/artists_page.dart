import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/common_widget/artist_song_row.dart';
import 'package:vina_music_app/page/songs/artist_detail_page/artist_detail_page.dart';
import 'package:vina_music_app/page/songs/artists_page/artists_viewmodel.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({super.key});

  @override
  State<ArtistsPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistsPage> {
  final artistsViewModel = Get.put(ArtistsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          itemCount: artistsViewModel.allList.length,
          itemBuilder: (context, index) {
            return ArtistSongRow(
                sObj: artistsViewModel.allList[index], onPressed: () => Get.to(ArtistDetailPage()),
                onPressedMenuSelect: null);
          },);
      },),
    );
  }
}
