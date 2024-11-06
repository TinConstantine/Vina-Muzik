import 'package:flutter/material.dart';

import '../common/color_extension.dart';
import '../common/image.dart';

class AlbumCell extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;
  final Function(int)? onSelected;

  const AlbumCell({super.key,
    required this.sObj,
    required this.onPressed,
    required this.onSelected,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              sObj["image"],
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  sObj["name"],
                  maxLines: 1,
                  style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 12,
                width: 12,
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
                  onSelected: onSelected,
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
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  sObj["artists"],
                  maxLines: 1,
                  style: TextStyle(
                    color: TColor.lightGray,
                    fontSize: 11,
                  ),
                ),
              ),
              Text(
                " • ",
                maxLines: 1,
                style: TextStyle(
                  color: TColor.lightGray,
                  fontSize: 11,
                ),
              ),
              Text(
                sObj["songs"],
                maxLines: 1,
                style: TextStyle(
                  color: TColor.lightGray,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
