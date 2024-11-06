import 'package:flutter/material.dart';
import 'package:vina_music_app/common/color_extension.dart';

import '../common/image.dart';

class ArtistSongRow extends StatelessWidget {
  final Map sObj;
  final Function(int select)? onPressedMenuSelect;
  final VoidCallback? onPressed;

  const ArtistSongRow(
      {super.key,
      required this.sObj,
      required this.onPressed,
      required this.onPressedMenuSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  child: Image.asset(
                    sObj["image"],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: TColor.primaryText28),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sObj["name"],
                    maxLines: 1,
                    style: TextStyle(
                        color: TColor.primaryText60,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${sObj["albums"]}\t\t${sObj["songs"]}",
                    maxLines: 1,
                    style: TextStyle(
                        color: TColor.primaryText80, fontSize: 11),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
              width: 25,
              child: PopupMenuButton(
                offset: const Offset(-10,15),
                color: TColor.contextMenu,
                elevation: 1,
                icon: Image.asset(
                  TImage.imgMoreButton,
                  width: 12,
                  height: 12,
                  color: TColor.primaryText,
                ),
                padding: EdgeInsets.zero,
                onSelected: onPressedMenuSelect,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      height: 32,
                      value: 1,
                      child: Text(
                        'Play',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 32,
                      value: 2,
                      child: Text(
                        'Play next',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 32,
                      value: 3,
                      child: Text(
                        'Add to playing queue',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ), PopupMenuItem(
                      height: 32,
                      value: 4,
                      child: Text(
                        'Add to playlist...',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 32,
                      value: 5,
                      child: Text(
                        'Rename',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 32,
                      value: 6,
                      child: Text(
                        'Tag editor',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 32,
                      value: 7,
                      child: Text(
                        'Go to artist',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 32,
                      value: 8,
                      child: Text(
                        'Delete from device',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 32,
                      value: 9,
                      child: Text(
                        'Share',
                        style: TextStyle(
                            fontSize: 12,
                            color: TColor.primaryText
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
