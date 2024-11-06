import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/common/state_helper.dart';
import 'package:vina_music_app/common_widget/album_cell.dart';
import 'package:vina_music_app/page/songs/album_detail_page/album_detail_detail.dart';
import 'package:vina_music_app/page/songs/albums_page/albums_viewmodel.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final albumsViewModel = Get.put(AlbumViewModel());

  @override
  Widget build(BuildContext context) {

    var cellWidth = (mediaSize.width - 60) * 0.5;
    return Scaffold(
      body: Obx(
        () {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            itemCount: albumsViewModel.allList.length,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              childAspectRatio: cellWidth/ (cellWidth + 48),
            ),
           itemBuilder: (context, index) {
             return AlbumCell(onPressed: (){
               Get.to(const AlbumDetailPage());
             },sObj: albumsViewModel.allList[index],onSelected: (p0) {
               print("You click index: $p0");
             },);
           },
          );
        },
      ),
    );
  }
}
