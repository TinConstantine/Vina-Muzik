import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/common_widget/genre_cell.dart';
import 'package:vina_music_app/page/songs/genres_page/genres_viewmodel.dart';

class GenresPage extends StatefulWidget {
  const GenresPage({super.key});

  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  final genresViewModel = Get.put(GenresViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            itemCount: genresViewModel.allList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4),
            itemBuilder: (context, index) {
              var item = genresViewModel.allList[index];
              return GenreCell(
                onPressed: null,
                obj: item,
              );
            },
          );
        },
      ),
    );
  }
}
