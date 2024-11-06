import 'package:flutter/material.dart';

import '../common/color_extension.dart';
import '../common/image.dart';

class AlbumSongsRow extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressed;
  final bool isPlay;

  const AlbumSongsRow(
      {super.key,
      required this.sObj,
      required this.onPressed,
      this.isPlay = false,
      required this.onPressedPlay});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onPressedPlay,
              icon: Image.asset(
                TImage.imgPlayButton,
                width: 25,
                height: 25,
              ),
            ),
            Expanded(
              child: Text(
                sObj["name"],
                maxLines: 1,
                style: TextStyle(
                    color: TColor.primaryText60,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              sObj["duration"],
              maxLines: 1,
              style: TextStyle(color: TColor.primaryText28, fontSize: 13),
            ),
            Container(
              width: 80, alignment: Alignment.centerRight,
              child: isPlay ? Image.asset(
                TImage.imgPlayEq,
                width: 60,
                height: 25,
              ) : Image.asset(
                TImage.imgMore,
                width: 25,
                height: 25,
              ),
            )
          ],
        ),
        Divider(
          color: Colors.white.withOpacity(0.07),
          indent: 44,
          // endIndent: 20,
        )
      ],
    );
  }
}
