import 'package:flutter/material.dart';

import '../common/color_extension.dart';
import '../common/image.dart';

class MyPlaylistSongsCell extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressed;

  const MyPlaylistSongsCell(
      {super.key,
      required this.sObj,
      required this.onPressed,
      required this.onPressedPlay});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          sObj["image"],
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black45,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      sObj["name"],
                      maxLines: 1,
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      sObj["songs"],
                      maxLines: 1,
                      style: TextStyle(
                        color: TColor.primaryText28,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onPressedPlay,
                child: Image.asset(
                  TImage.imgPlay,
                  width: 22,
                  height: 22,
                ),
              )
            ],
          ),
        ),
      ],

    );
  }
}
