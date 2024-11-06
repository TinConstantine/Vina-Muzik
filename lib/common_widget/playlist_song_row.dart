import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:vina_music_app/audio_helpers/page_manager.dart';

import '../audio_helpers/service_locator.dart';
import '../common/color_extension.dart';
import '../common/image.dart';

class PlaylistSongRow extends StatelessWidget {
  final MediaItem sObj;
  final Widget right;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressed;

  const PlaylistSongRow(
      {super.key,
        required this.right,
        required this.sObj,
        required this.onPressed,
        required this.onPressedPlay});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      sObj.artUri.toString(),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: TColor.primaryText28),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sObj.title,
                      maxLines: 1,
                      style: TextStyle(
                          color: TColor.primaryText60,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      sObj.artist.toString(),
                      maxLines: 1,
                      style: TextStyle(color: TColor.primaryText28, fontSize: 10),
                    )
                  ],
                ),
              ),
              right,
              IconButton(
                onPressed: onPressedPlay,
                icon: Image.asset(
                  TImage.imgPlayButton,
                  width: 25,
                  height: 25,
                ),
              ),
            ],
      
          ),
          Divider(
            color: Colors.white.withOpacity(0.07),
            indent: 60,
            // endIndent: 20,
          )
        ],
      ),
    );
  }
}
